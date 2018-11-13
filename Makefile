#-----------------------------------------------------------------------------$
# DEPENDENCY INCLUDES
#------------------------------------------------------------------------------

-include Makefile.config

#------------------------------------------------------------------------------
# BUILD TOOLS
#------------------------------------------------------------------------------

CC = gcc  # C Compiler
CL = gcc  # Linker

#------------------------------------------------------------------------------
# SHELL COMMANDS
#------------------------------------------------------------------------------

ifeq (${OS}, Windows_NT)
    SHELL = cmd             # Shell that used by the host.

    MKDIR = mkdir 2>nul     # Make directory and suspend any error.
    RMDIR = rd /s /q 2>nul  # Remove directory and suspend any error.

    # Function that used to search source files.
    define find
        $(subst ${CURDIR},${PROJ_PATH},
          $(subst \,/,$(shell "where" 2>nul /r $(subst /,\,${1}) ${2})))
    endef
else
    SHELL = /bin/sh         # Shell that used by the host.

    MKDIR = mkdir -p        # Make directory and suspend any error.
    RMDIR = rm -rf          # Remove directory and suspend any error.

    # Function that used to search source files.
    define find
        $(shell find ${1} -name "${2}")
    endef
endif

#------------------------------------------------------------------------------
# EXTENSIONS
#------------------------------------------------------------------------------

# If the host operating system is any version of Microsoft Windows, output
# file's extension is ".exe". If it is a Unix-like system, extension is ".out".

ifeq (${OS}, Windows_NT)
    OUT_EXT = .exe
else
    OUT_EXT = .out
endif

#------------------------------------------------------------------------------
#  CONFIGURATION ERROR CHECKS
#------------------------------------------------------------------------------

ifndef PROJ
    $(error "Project name must be specified!")
endif

#------------------------------------------------------------------------------
# PATH DEFINITIONS
#------------------------------------------------------------------------------

PROJ_PATH  = .
BIN_PATH   = $(addsuffix /bin, ${PROJ_PATH})

#------------------------------------------------------------------------------
# INPUT & OUTPUT FILE DEFINITIONS
#------------------------------------------------------------------------------

INC   = $(addprefix -I , ${INC_PATH})

SRC   = $(call find, ${PROJ_PATH},*.c)
SRC  += $(call find, ${PROJ_PATH},*.s)

OBJ   = $(patsubst ${PROJ_PATH}/%.c,${BIN_PATH}/%.o, ${SRC})
OBJ  := $(patsubst ${PROJ_PATH}/%.s,${BIN_PATH}/%.o, ${OBJ})

OUT   = $(addprefix ${BIN_PATH}/, ${PROJ})
OUT  := $(addsuffix ${OUT_EXT}, ${OUT})

#------------------------------------------------------------------------------
# MAKE RULES
#------------------------------------------------------------------------------

.PHONY: all build clean rebuild ${OUT}

all:
	@${MAKE} --no-print-directory build
	@${MAKE} --no-print-directory ${OUT}
	@echo "Project Build Successfully"

clean:
	@${RMDIR} "${BIN_PATH}" ||:
	@echo "Project Cleaned Successfully"

build: ${OBJ}
	@echo "Objects Build Successfully"

rebuild:
	@${MAKE} --no-print-directory clean
	@${MAKE} --no-print-directory all

#------------------------------------------------------------------------------
# BUILD CONFIGURATIONS
#------------------------------------------------------------------------------

${OUT}:
	${CL} -o ${OUT} ${OBJ} ${CL_FLAG}

${BIN_PATH}/%.o: ${PROJ_PATH}/%.c
	@${MKDIR} "$(dir $@)" ||:
	${CC} ${INC} -c -o $@ $< ${CC_FLAG}

${BIN_PATH}/%.o: ${PROJ_PATH}/%.s
	@${MKDIR} "$(dir $@)" ||:
	${CC} ${INC} -c -o $@ $< ${CC_FLAG}
