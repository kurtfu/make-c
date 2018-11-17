#------------------------------------------------------------------------------
# DEPENDENCY INCLUDES
#------------------------------------------------------------------------------

-include Makefile.config
-include Makefile.target

#------------------------------------------------------------------------------
#  CONFIGURATION ERROR CHECKS
#------------------------------------------------------------------------------

ifndef PROJ
    $(error "Project name must be specified!")
endif

ifndef TYPE
    $(error "Output type must be specified!")
endif

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
          $(subst \,/,$(shell "where" 2>nul /r ${1} ${2})))
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

EXEC  = $(addprefix ${BIN_PATH}/, ${PROJ})
EXEC := $(addsuffix ${OUT_EXT}, ${EXEC})

SLIB  = $(addprefix ${BIN_PATH}/, ${PROJ})
SLIB := $(addsuffix .a, ${SLIB})

ifeq (${TYPE}, EXEC)
	OUT = ${EXEC}
else ifeq (${TYPE}, SLIB)
	OUT = ${SLIB}
endif

#------------------------------------------------------------------------------
# MAKE RULES
#------------------------------------------------------------------------------

.PHONY: all build clean rebuild ${OUT}

all: build ${OUT}
	@echo "Project Build Successfully"

build: ${OBJ}
	@echo "Objects Build Successfully"

clean:
	@${RMDIR} "${BIN_PATH}" ||:
	@echo "Project Cleaned Successfully"

rebuild: clean all

#------------------------------------------------------------------------------
# BUILD RULES
#------------------------------------------------------------------------------

${EXEC}:
	${CL} -o ${OUT} ${OBJ} ${CL_FLAG}

${SLIB}:
	${AR} -crv ${SLIB} ${OBJ}

${BIN_PATH}/%.o: ${PROJ_PATH}/%.c
	@${MKDIR} "$(dir $@)" ||:
	${CC} ${INC} -c -o $@ $< ${CC_FLAG}

${BIN_PATH}/%.o: ${PROJ_PATH}/%.s
	@${MKDIR} "$(dir $@)" ||:
	${CC} ${INC} -c -o $@ $< ${CC_FLAG}
