# Docker Cross Compilation Example

This is a simple example of how to use Docker to cross compile an application.

## Structure

* `Dockerfile` - The Dockerfile that defines the Docker image to be used in
Cross compilation. This file must define all the environment variables, tools
and dependencies needed for compilation. Of note, this Dockerfile is agnostic
to the platform being compiled for. It is only concerned with the tools and
dependencies needed for compilation.
* `docker-compose.yml` - The docker-compose file defines the platforms the
Docker images are to be built for, the files loaded from the host to the
containers created from these images, and the commands to be run.

The remainder of the repository is the source code for the application and the
Makefile that defines the build process. This will vary from application to
application.

## Setting up `docker buildx`

The host machine must have `docker buildx` installed. Please consult
<https://github.com/docker/buildx> for instructions on how to install this.

What is required is that your bootstrapped `docker buildx` instance has
builders for each of the architectures you wish to compile for. In this
example, we are compiling for `amd64`, `arm64` and `riscv64`. To create
these builds, we execute the following commands:

```bash
docker buildx create --use --name mybuild node-amd64
docker buildx create --append --name mybuild node-arm64
docker buildx create --append --name mybuild node-riscv64
```

Here a new builder, `mybuild` is created for `amd64` then appended to with the
`arm64` and `riscv64`. The `--use` flag is used to set the builder as the
default.

## Usage

All you need to do to create the cross compiled binaries is run:

```bash
docker-compose up
```

For each architecture to be compiled to this command, by reading the
`docker-compose.yml` file, will create an Image from the Dockerfile
for that architecture, create a container from that image, mount the local
source code into the container, then build and return the compiled product.
