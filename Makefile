# SPDX-License-Identifier: MIT

# This Makefile is used to build the hello-world example. There is nothing
# Special here, only that we use the TARGETARCH environment variable to
# create a subdirectory for the target architecture.

all: bin/${TARGETARCH}/hello-world

bin/${TARGETARCH}/hello-world: bin/${TARGETARCH} src/hello-world.cc
	g++ -o bin/${TARGETARCH}/hello-world src/hello-world.cc

bin/${TARGETARCH}:
	mkdir -p bin/${TARGETARCH}

clean:
	-rm -fr bin
