#!/usr/bin/env sh
VER=0.26.1
MIRROR=https://github.com/bazelbuild/bazel/releases/download/$VER

dl()
{
    OS=$1
    PLATFORM=$2
    EXESUFFIX=${3:-}
    URL=$MIRROR/bazel-$VER-$OS-$PLATFORM$EXESUFFIX.sha256
    printf "%s-%s: sha256:%s\n" $OS $PLATFORM `curl -SsL $URL | awk '{print $1}'`
}

dl linux x86_64
dl darwin x86_64
dl windows x86_64 .exe

