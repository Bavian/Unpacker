#!/bin/bash

. md5sums/constants.env

directory_to_calculate=$(realpath "$1")
cd "$directory_to_calculate"

while read line; do
  file=${line#./}
  [[ -d "$file" ]] && continue
  [[ "$file" == "$CACHED_FILE_NAME" ]] && continue
  md5sum "$file"
done <<< $(find .)
