#------------------------------------------------------------------------------
# BUILD TOOLS
#------------------------------------------------------------------------------

CC = gcc  # C Compiler
CL = gcc  # Linker
AR = ar   # Archiver

#------------------------------------------------------------------------------
# COMPILER OPTIONS
#------------------------------------------------------------------------------

# The tag describes the language standard. To use a language standard while
# compiling, specify it before build. If the tag left blank, compiler's
# default standard is used. For GCC, default standard is GNU90.
# Supported standards:
# ANSI -> ANSI C standard
# C99  -> 1999 ISO C standard
# C11  -> 2011 ISO C standard

STD = C99

#------------------------------------------------------------------------------
# EXTENSIONS
#------------------------------------------------------------------------------

ifeq (${OS}, Windows_NT)
    OUT_EXT = .exe  # Output extension on Microsof Windows
else
    OUT_EXT = .out  # Output extension on Unix-like systems
endif
