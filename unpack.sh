#!/bin/bash

. colors.env

# GLOBAL SCOPE DECLARATIONS

## CONSTANTS

### CURSOR MOVERS

CURSOR_TO_LINE_START="\r\033[K"
CURSOR_TO_PREVIOUS_LINE="\e[1A"

# MAIN ENTRY POINT

if [ $# == 0 ]; then
	FROM_PATH="."
else
  FROM_PATH="$1"
fi
FROM_PATH=$(realpath "$FROM_PATH")

if [ $# -lt 2 ]; then
  TO_PATH="$FROM_PATH/unpacked"
else
  TO_PATH=$(realpath "$2")
fi

echo Unpack from \""$FROM_PATH"\" to \""$TO_PATH"\"

echo Removing old directory...
rm -fr "$TO_PATH"
mkdir -p "$TO_PATH"

files=$(find "$FROM_PATH" -name "*.zip" -o -name "*.rar" -o -name "*.7z")
files_amount=$(wc -l <<< "$files")
echo Amount of files is "$files_amount"

echo Start to unpack...
counter=0
while read -r file; do
  dir_name=${file#"$FROM_PATH/"}
  elements_count=$(bash list_files.sh "$file" | wc -l)
  full_name="$TO_PATH/$dir_name"
  if [ "$elements_count" -le "1" ]; then
    file_basename=$(basename "$file")
    full_name=${full_name%"$file_basename"}
  else
    full_name=${full_name%.*}
  fi

  next_file_info="$((counter+1)). $dir_name"
  echo "$next_file_info"
  echo -e -n "$counter/$files_amount"

  status_of_result="${COLOR_RED}X${COLOR_RESET}"
  if 7z -y -o"$full_name" x "$file" > /dev/null 2> /dev/null; then
    status_of_result="${COLOR_GREEN}V${COLOR_RESET}"
  fi
  echo -e -n "$CURSOR_TO_LINE_START$CURSOR_TO_PREVIOUS_LINE"
  echo -e "$next_file_info $status_of_result"

  ((counter=counter+1))
done <<< "$files"

echo -e "\r\033[K$files_amount/$files_amount"

