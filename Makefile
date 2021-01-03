#------------------------------------------------------------------------------
# PROJECT CONFIGURATIONS
#------------------------------------------------------------------------------

# The tag describes the name of the project. Project name must be a single
# word. Whitespaces are not allowed. To use word sequences, separate the
# words with underscore.
PROJ      =

#------------------------------------------------------------------------------
# SOURCE CONFIGURATIONS
#------------------------------------------------------------------------------

# The tag describes the exclude files of the project. Any element of the tag
# is not compiled.
EXL_FILE  =

# The tag specifies assembly file generation option. If the tag set as 'YES',
# build system generates assembly files in addition to object files.
GEN_ASM   =

#------------------------------------------------------------------------------
# COMPILER AND LINKER CONFIGURATIONS
#------------------------------------------------------------------------------

# The tag describes the search path for header files of the project.
INC_PATH  =

#------------------------------------------------------------------------------
# BUILD TOOLS
#------------------------------------------------------------------------------

CC = gcc  # C Compiler
LD = gcc  # Linker

#------------------------------------------------------------------------------
# COMPILER FLAGS
#------------------------------------------------------------------------------

CC_FLAGS =   \
    -Wall    \
    -Wextra  \
    -std=c99 \
    -O3

#------------------------------------------------------------------------------
#  DEFAULT CONFIGURATION CHECKS
#------------------------------------------------------------------------------

# If not defined, set the project name same with the root folder name.
ifndef PROJ
    PROJ = $(notdir ${CURDIR})
endif

#------------------------------------------------------------------------------
# SHELL COMMANDS
#------------------------------------------------------------------------------

ifeq (${OS}, Windows_NT)
    SHELL = cmd             # Shell that used by the host.

    MKDIR = mkdir 2>nul     # Make directory and suspend any error.
    RMDIR = rd /s /q 2>nul  # Remove directory and suspend any error.

    OUT_EXT = .exe          # Output extension on Microsof Windows

    # Replace slashes due to the Windows path notation.
    CURDIR := $(subst /,\,${CURDIR})

    # Function that used to search source files.
    define find
        $(subst ${CURDIR},${PROJ_PATH},$(shell "where" 2>nul /r ${1} ${2}))
    endef
else
    SHELL = /bin/sh         # Shell that used by the host.

    MKDIR = mkdir -p        # Make directory and suspend any error.
    RMDIR = rm -rf          # Remove directory and suspend any error.

    OUT_EXT = .out          # Output extension on Unix-like systems

    # Function that used to search source files.
    define find
        $(shell find ${1} -name "${2}")
    endef
endif

#------------------------------------------------------------------------------
# PATH DEFINITIONS
#------------------------------------------------------------------------------

PROJ_PATH  = .
BIN_PATH   = $(addsuffix /bin, ${PROJ_PATH})
BUILD_PATH = $(addsuffix /build, ${PROJ_PATH})

#------------------------------------------------------------------------------
# INPUT & OUTPUT FILE DEFINITIONS
#------------------------------------------------------------------------------

INC   = $(addprefix -I, ${INC_PATH})

SRC   = $(call find, ${PROJ_PATH},*.c)
SRC  += $(call find, ${PROJ_PATH},*.s)

# Replace slashes due to the Windows path notation.
ifeq (${OS}, Windows_NT)
    SRC := $(subst \,/,${SRC})
endif

SRC  := $(filter-out ${EXL_FILE}, ${SRC})
SRC  := $(filter-out ${BUILD_PATH}/%.s,${SRC})

ASM   = $(patsubst ${PROJ_PATH}/%.c,${BUILD_PATH}/%.s, ${SRC})

OBJ   = $(patsubst ${PROJ_PATH}/%.c,${BUILD_PATH}/%.o, ${SRC})
OBJ  := $(patsubst ${PROJ_PATH}/%.s,${BUILD_PATH}/%.o, ${OBJ})

OUT   = $(addprefix ${BIN_PATH}/, ${PROJ})
OUT  := $(addsuffix ${OUT_EXT}, ${OUT})

BUILD_DEPS = ${OBJ}

ifeq (${GEN_ASM}, YES)
    BUILD_DEPS += ${ASM}
endif

#------------------------------------------------------------------------------
# MAKE RULES
#------------------------------------------------------------------------------

.PHONY: all clean

all: ${OUT}
	@echo "Project Build Successfully"

clean:
	@${RMDIR} "${BIN_PATH}" ||:
	@${RMDIR} "${BUILD_PATH}" ||:
	@echo "Project Cleaned Successfully"

#------------------------------------------------------------------------------
# BUILD RULES
#------------------------------------------------------------------------------

${OUT}: ${BUILD_DEPS}
	@${MKDIR} "$(dir $@)" ||:
	${LD} -o $@ ${OBJ} ${LD_FLAGS}

${BUILD_PATH}/%.o: ${PROJ_PATH}/%.c
	@${MKDIR} "$(dir $@)" ||:
	${CC} -c -o $@ $< ${INC} ${CC_FLAGS}

${BUILD_PATH}/%.o: ${PROJ_PATH}/%.s
	@${MKDIR} "$(dir $@)" ||:
	${CC} -c -o $@ $< ${INC} ${CC_FLAGS}

${BUILD_PATH}/%.s: ${PROJ_PATH}/%.c
	@${MKDIR} "$(dir $@)" ||:
	${CC} -S -o $@ $< ${INC} ${CC_FLAGS}
