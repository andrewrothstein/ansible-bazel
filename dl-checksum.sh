#!/usr/bin/env sh
VER=0.24.1
MIRROR=https://github.com/bazelbuild/bazel/releases/download/$VER

dl()
{
    OS=$1
    PLATFORM=$2
    EXESUFFIX=${3:-}
    URL=$MIRROR/bazel-$VER-$OS-$PLATFORM$EXESUFFIX.sha256
    curl -SsL $URL
}

dl linux x86_64
dl darwin x86_64
dl windows x86_64 .exe

