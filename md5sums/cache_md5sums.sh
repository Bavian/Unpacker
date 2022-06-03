#!/bin/bash

# GLOBAL

## CONSTANTS

AIM_ADD="a"
AIM_DELETE="d"
AIM_UPDATE="u"

# MAIN ENTRY POINT

aim=$1
archive=$2

CACHED_FILES_AMOUNT=$(bash md5sums/get_cached_files_amount.sh "$archive")
echo "files: " "$CACHED_FILES_AMOUNT"

case "$aim" in
  "$AIM_ADD")
  echo Add operation is not implemented
  ;;
  "$AIM_DELETE")
  if [[ "$CACHED_FILES_AMOUNT" -ge 1 ]]; then
    echo Delete operation is not implemented
  else
    echo No cache file. Nothing to do
  fi
  ;;
  "$AIM_UPDATE")
  echo Update operation is not implemented
  ;;
esac

