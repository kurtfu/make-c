# Make-C

Generic GNU Make build system for C projects.

## Table of Contents
- [Introduction](#introduction)
- [How to Use](#how-to-use)
- [Configuration](#configuration)
- [License](#license)
- [See Also](#see-also)

## Introduction

The system was designed to simplify building large C projects. It can be used
for any platform as long as build specifications  configured correctly.

## How to Use

To use the build system, `GNU Make` must be installed. If it is already
installed, no further action is required to use build system.
[Makefile](Makefile) and `build` folder must be placed to the project root.
The rest is handled by the build system.

Source files are found, compiled and linked automatically. Object files(and
assembly files if the `ASM_GEN` flag is set) and out file are placed to `bin`
folder.

To build the project, at the project root folder, run:

```
$ make
```

To remove all generated files, run:

```
$ make clean
```

__NOTE:__ Every compiler has different features and flags. Therefore,
build rules may have to be rewritten.

## Configuration

System configurations are found at the first part of [Makefile](Makefile).

## License

This project is licensed under the MIT License - see the
[LICENSE](LICENSE) file for details.

## See Also

- [GNU Make](https://www.gnu.org/software/make/)
