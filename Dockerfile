# SPDX-License-Identifier: MIT

# `--platform=$BUILDPLATFORM` is a special flag that instructs the builder to
# obtain the image for the specified architecture. By default the image is
# that of the host archtecture but `--platform` allows us to override that.
FROM --platform=$BUILDPLATFORM alpine:latest AS builder

# Here we take note of the target architecture and set it to an environment
# variable. This isn't necessiary but we use it in the "Makefile" to create
# directories for each architecture we're compiling to.
ARG TARGETARCH
ENV TARGETARCH=$TARGETARCH

# Here we add any dependencies we need to build our application. As, in this
# example, we're building a simple "Hello World" application we don't need
# much. In more complex builds, there may be considerably more needed here.
RUN apk add --no-cache build-base
