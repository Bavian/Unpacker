#!/bin/bash

. md5sums/constants.env

echo $(bash list_files.sh "$1" | grep "$CACHED_FILE_NAME" | wc -l)

