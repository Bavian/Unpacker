#!/bin/bash

# GLOBAL SCOPE DECLARATIONS
_basename_without_extension() {
  local _basename
  _basename=$(basename "$1")
  _basename_without_extension_result=${_basename%.*}
}

_count_elements() {
  _count_elements_result=$(7z l -slt "$1" | grep -c "Path = ")
}

# UNPACKING ENTRY POINT
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
  if [ $counter != 0 ]; then
    echo -e -n "\r\033[K"
  fi
  echo "$next_file_info"
  echo -e -n "$counter/$files_amount"

  7z -y -o"$full_name" x "$file" > /dev/null

  ((counter=counter+1))
done

echo -e "\r\033[K$files_amount/$files_amount"

