#------------------------------------------------------------------------------
# PROJECT CONFIGURATIONS
#------------------------------------------------------------------------------

# The tag describes the name of the project. Project name must be a single
# word. Whitespaces are not allowed. To use word sequences, separate the
# words with underscore.

PROJ      =

# The tag describes the output type of the project. Before build the project,
# output type must be specified. Two types are supported:
# EXEC -> Executable output.
# SLIB -> Static library.

TYPE      =

#------------------------------------------------------------------------------
# SOURCE CONFIGURATIONS
#------------------------------------------------------------------------------

# The tag describes the exclude files of the project. Any element of this tag
# is not compiled within the project. Multiple files could be added by
# separating with whitespace. If the tag left blank, all files under the
# project root folder is compiled.

EXL_FILE +=

# The tag specifies assembly file generation option. If the tag set as 'YES',
# build system generates assembly files in addition to object files.
# Otherwise, build system generates only object files.

KEEP_ASM  =

#------------------------------------------------------------------------------
# COMPILER AND LINKER CONFIGURATIONS
#------------------------------------------------------------------------------

# The tag describes the include path of the project. Multiple paths could be
# added by separating with whitespace. If the tag left blank, only default
# system path is used.

INC_PATH +=