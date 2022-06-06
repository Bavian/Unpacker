#!/bin/bash

. md5sums/constants.env

directory_to_calculate=$(realpath "$1")
archive_to_add=$(realpath "$2")

bash md5sums/calculate_md5sums.sh "$directory_to_calculate" > "$CACHED_FILE_NAME"
7z a "$archive_to_add" "$CACHED_FILE_NAME"
rm "$CACHED_FILE_NAME"
