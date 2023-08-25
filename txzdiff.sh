#!/bin/bash

# Check if there are exactly two arguments
if [[ $# -ne 2 ]]; then
    echo "Usage: $0 <tar1.xz> <tar2.xz>"
    exit 1
fi

tar1="$1"
tar2="$2"

# temporary directories for extraction
dir1=$(mktemp -d)
dir2=$(mktemp -d)

# extract archives
tar -xf "$tar1" -C "$dir1"
tar -xf "$tar2" -C "$dir2"

# process XML files
find "$dir1" "$dir2" -name '*.xml' -exec xmllint --format --output '{}' '{}' \;

# process BIN files
find "$dir1" "$dir2" -name '*.bin' -exec sh -c 'hexdump "$1" > "$1.hex"' _ '{}' \;

# diff contents
diff -ru "$dir1" "$dir2"

# cleanup temporary directories
rm -rf "$dir1" "$dir2"
