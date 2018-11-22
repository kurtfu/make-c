#------------------------------------------------------------------------------
# BUILD TOOLS
#------------------------------------------------------------------------------

CC = gcc  # C Compiler
CL = gcc  # Linker
AR = ar   # Archiver

#------------------------------------------------------------------------------
# EXTENSIONS
#------------------------------------------------------------------------------

ifeq (${OS}, Windows_NT)
    OUT_EXT = .exe  # Output extension on Microsof Windows
else
    OUT_EXT = .out  # Output extension on Unix-like systems
endif
