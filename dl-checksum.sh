#!/usr/bin/env sh
MIRROR=https://github.com/bazelbuild/bazel/releases/download

dl()
{
    local ver=$1
    local app=$2
    local os=$3
    local arch=$4
    local exesuffix=${5:-}
    local platform="${os}-${arch}"
    local url=$MIRROR/$ver/$app-$ver-$platform${exesuffix}.sha256
    printf "    # %s\n" $url
    printf "    %s-%s: sha256:%s\n" $os $arch $(curl -SsLf $url | awk '{print $1}')
}

dl_bazel() {
    local ver=$1
    local app=bazel
    printf "%s_checksums:\n" $app
    printf "  '%s':\n" $ver
    dl $ver $app linux x86_64
    dl $ver $app darwin x86_64
    dl $ver $app windows x86_64 .exe
}

dl_bazel_nojdk() {
    local ver=$1
    local app=bazel_nojdk
    printf "%s_checksums:\n" $app
    printf "  '%s':\n" $ver
    dl $ver $app linux x86_64
    dl $ver $app darwin x86_64
}

VER=${1:-5.3.0}
dl_bazel $VER
dl_bazel_nojdk $VER
