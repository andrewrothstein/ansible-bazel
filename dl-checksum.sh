#!/usr/bin/env sh
VER=0.29.1
MIRROR=https://github.com/bazelbuild/bazel/releases/download/$VER

dl()
{
    local os=$1
    local arch=$2
    local exesuffix=${3:-}
    local url=$MIRROR/bazel-$VER-$os-$arch$exesuffix.sha256
    printf "    # %s\n" $url
    printf "    %s-%s: sha256:%s\n" $os $arch `curl -SsL $url | awk '{print $1}'`
}

printf "  '%s':\n" $VER
dl linux x86_64
dl darwin x86_64
dl windows x86_64 .exe

