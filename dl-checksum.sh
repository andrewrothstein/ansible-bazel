#!/usr/bin/env sh
MIRROR=https://github.com/bazelbuild/bazel/releases/download

dl()
{
    local ver=$1
    local os=$2
    local arch=$3
    local exesuffix=${4:-}
    local platform="${os}-${arch}"
    local url=$MIRROR/$ver/bazel-$ver-$platform${exesuffix}.sha256
    printf "    # %s\n" $url
    printf "    %s-%s: sha256:%s\n" $os $arch `curl -SsL $url | awk '{print $1}'`
}

dl_ver() {
    local ver=$1
    printf "  '%s':\n" $ver
    dl $ver linux x86_64
    dl $ver darwin x86_64
    dl $ver windows x86_64 .exe
}

dl_ver ${1:-3.7.2}
