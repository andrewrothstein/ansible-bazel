#!/usr/bin/env sh
set -e
MIRROR=https://github.com/bazelbuild/bazel/releases/download
OUT_DIR=${OUT_DIR:-defaults/main}
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

dl()
{
    local ver=$1
    local app=$2
    local os=$3
    local arch=$4
    local exesuffix=${5:-}
    local platform="${os}-${arch}"
    local url="$MIRROR/$ver/$app-$ver-$platform${exesuffix}.sha256"
    local sum
    sum=$(curl -fsSL --proto '=https' --tlsv1.2 "$url" | awk '{print $1}')
    if ! printf '%s' "$sum" | grep -Eq '^[0-9a-f]{64}$'
    then
        echo "bad or missing checksum from $url: '$sum'" >&2
        exit 1
    fi
    printf "    # %s\n" "$url"
    printf "    %s-%s: sha256:%s\n" "$os" "$arch" "$sum"
}

dl_bazel() {
    local ver=$1
    local app=bazel
    printf "  '%s':\n" "$ver"
    dl "$ver" $app linux arm64
    dl "$ver" $app linux x86_64
    dl "$ver" $app darwin arm64
    dl "$ver" $app darwin x86_64
    dl "$ver" $app windows x86_64 .exe
}

dl_bazel_nojdk() {
    local ver=$1
    local app=bazel_nojdk
    printf "  '%s':\n" "$ver"
    dl "$ver" $app linux arm64
    dl "$ver" $app linux x86_64
    dl "$ver" $app darwin arm64
    dl "$ver" $app darwin x86_64
}

# build both outputs first so a failure appends nothing to either file
dl_ver() {
    local ver=$1
    dl_bazel "$ver" > "$TMP/bazel.yml"
    dl_bazel_nojdk "$ver" > "$TMP/bazel_nojdk.yml"
    cat "$TMP/bazel.yml" >> "$OUT_DIR/bazel_checksums.yml"
    cat "$TMP/bazel_nojdk.yml" >> "$OUT_DIR/bazel_nojdk_checksums.yml"
}

for v in "${@:-9.3.3}"; do
    dl_ver "$v"
done
