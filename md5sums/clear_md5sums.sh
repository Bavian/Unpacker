#!/bin/bash

. md5sums/constants.env

7z d "$1" "$CACHED_FILE_NAME"

