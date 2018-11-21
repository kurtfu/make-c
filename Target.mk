#------------------------------------------------------------------------------
# BUILD TOOLS
#------------------------------------------------------------------------------

CC = gcc  # C Compiler
CL = gcc  # Linker

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
