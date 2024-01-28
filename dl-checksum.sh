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
    printf "  '%s':\n" $ver
    dl $ver $app linux arm64
    dl $ver $app linux x86_64
    dl $ver $app darwin arm64
    dl $ver $app darwin x86_64
    dl $ver $app windows x86_64 .exe
}

dl_bazel_nojdk() {
    local ver=$1
    local app=bazel_nojdk
    printf "  '%s':\n" $ver
    dl $ver $app linux arm64
    dl $ver $app linux x86_64
    dl $ver $app darwin arm64
    dl $ver $app darwin x86_64
}

dl_ver() {
    ver=$1
    dl_bazel $ver >> defaults/main/bazel_checksums.yml
    dl_bazel_nojdk $ver >> defaults/main/bazel_nojdk_checksums.yml
}

dl_ver ${1:-7.0.2}
