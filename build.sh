#!/bin/bash
# 多架构编译
# docker run --rm --privileged tonistiigi/binfmt:latest --install all
# docker buildx create --name multi-arch-builder   --driver docker-container   --bootstrap --use
VERSION=0.4.2
docker buildx build \
    --platform linux/amd64,linux/arm64 \
    --build-arg  NEXUS_VERSION=${VERSION} \
    -t jagerzhang/nexus-client:v${VERSION}  \
    --push .
