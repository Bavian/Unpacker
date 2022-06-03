#!/bin/bash

# GLOBAL SCOPE DECLARATIONS

## CONSTANTS

### CURSOR MOVERS

CURSOR_TO_LINE_START="\r\033[K"
CURSOR_TO_PREVIOUS_LINE="\e[1A"

### COLORS

RED="\033[0;31m"
GREEN="\033[0;32m"
RESET_COLOR="\033[0m"

## FUNCTIONS

_basename_without_extension() {
  local _basename
  _basename=$(basename "$1")
  _basename_without_extension_result=${_basename%.*}
}

_count_elements() {
  _count_elements_result=$(7z l -slt "$1" | grep -c "Path = ")
}

# MAIN ENTRY POINT

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

echo Removing old directory...
rm -fr "$TO_PATH"
mkdir -p "$TO_PATH"

files_amount=$(ls "$FROM_PATH"/*.zip \
  "$FROM_PATH"/*.rar \
  "$FROM_PATH"/*.7z \
  2> /dev/null \
  | wc -l)
echo Amount of files is "$files_amount"

echo Start to unpack...
counter=0
for file in "$FROM_PATH"/*.zip "$FROM_PATH"/*.rar "$FROM_PATH"/*.7z; do
  [ -f "$file" ] || continue
  _basename_without_extension "$file"
  dir_name=$_basename_without_extension_result
  _count_elements "$file"
  full_name="$TO_PATH"
  if [ "$_count_elements_result" -ne "2" ]; then
    full_name="$full_name/$dir_name"
  fi

  next_file_info="$((counter+1)). $dir_name"
  echo "$next_file_info"
  echo -e -n "$counter/$files_amount"

  status_of_result="${RED}X${RESET_COLOR}"
  if 7z -y -o"$full_name" x "$file" > /dev/null 2> /dev/null; then
    status_of_result="${GREEN}V${RESET_COLOR}"
  fi
  echo -e -n "$CURSOR_TO_LINE_START$CURSOR_TO_PREVIOUS_LINE"
  echo -e "$next_file_info $status_of_result"

  ((counter=counter+1))
done

echo -e "\r\033[K$files_amount/$files_amount"

