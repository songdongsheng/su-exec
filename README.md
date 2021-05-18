# su-exec

This repository is a Skynet Labs fork of [songdongsheng/su-exec](https://github.com/songdongsheng/su-exec).

Original readme is archived at [README.original.md](README.original.md).

`su-exec` is used to execute a program with given privileges. E.g. to execute
`Sia` (`siad` or `skyd`) as a non root user in a docker container.

Skynet Labs needs just `su-exec-musl-static` and `su-exec-glibc-static-arm64`
binaries.

## Build

To build `su-exec-musl-static` and `su-exec-glibc-static-arm64` binaries,
execute:  
`make -f Makefile.docker.skynetlabs`

## Test

To test `su-exec-musl-static` binary, execute:  
`./docker-test.skynetlabs.sh`

Alpine and Debian tests must pass.

## Released binary

Skynet Labs built, tested and released binaries will be available in this
repository under `Releases`.