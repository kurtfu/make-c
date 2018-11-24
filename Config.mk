#------------------------------------------------------------------------------
# PROJECT CONFIGURATIONS
#------------------------------------------------------------------------------

# The tag describes the name of the project. Project name must be a single
# word. Whitespaces are not allowed. To use word sequences, separate the
# words with underscore.

PROJ      =

# The tag describes the output type of the project. Before build the project,
# output type must be specified.
# Supported types:
# EXEC -> Executable output.
# SLIB -> Static library.

TYPE      =

#------------------------------------------------------------------------------
# SOURCE CONFIGURATIONS
#------------------------------------------------------------------------------

# The tag describes the exclude files of the project. Any element of the tag
# is not compiled. Multiple files could be added.

EXL_FILE +=

# The tag specifies assembly file generation option. If the tag set as 'YES',
# build system generates assembly files in addition to object files.
# Otherwise, build system generates only object files.

KEEP_ASM  =

#------------------------------------------------------------------------------
# COMPILER AND LINKER CONFIGURATIONS
#------------------------------------------------------------------------------

# The tag describes the include path of the project. Multiple paths could be
# added.

INC_PATH +=
