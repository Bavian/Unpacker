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

