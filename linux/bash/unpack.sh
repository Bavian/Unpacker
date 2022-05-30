#!/bin/bash

if [ $# == 0 ]; then
	FROM_PATH="."
else
FROM_PATH=$(realpath "$1")
fi

if [ $# -lt 2 ]; then
TO_PATH="$FROM_PATH/unpacked"
else
TO_PATH=$(realpath "$2")
fi

echo Unpack from \""$FROM_PATH"\" to \""$TO_PATH"\"

FILES_AMOUNT=$(ls "$FROM_PATH"/*.zip \
  "$FROM_PATH"/*.rar \
  "$FROM_PATH"/*.7z \
  2> /dev/null \
  | wc -l)
echo Amount of files is "$FILES_AMOUNT"
