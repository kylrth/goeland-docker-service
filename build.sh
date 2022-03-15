#!/bin/bash

set -e

# get the latest tag name
TAG=$(curl -sL https://api.github.com/repos/slurdge/goeland/releases/latest | grep tag_name | cut -d'"' -f4)

# build with buildkit so that TARGETARCH arg is available
DOCKER_BUILDKIT=1 docker build --build-arg TAG=$TAG -t goeland:$TAG -t goeland:latest .
