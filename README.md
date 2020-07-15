# PyBASE #

Containerized python environment.

## Installation ##

To simplify dependency management, these scripts can be run inside of a purpose-built
container.

Before running the scripts, be sure to build (or rebuild) the container:

    make build

## Launching ##

To invokve the container, simply run `make run` from the base directory.

Optionally, `make` can be executed from any directory using the `-C`flag.  This will create
a specific mount point in the container for the current directory (see Mount Points below).

For example:

    make -C MyDB run

### Mount Points ###

The following mount points are created by the `make run` target:

* `/mnt/host/files` - the root filesystem of the host
* `/mnt/host/home` - the home directory of the current user
* `/mnt/host/pwd` - the local directory where `make` was invoked

