#!/bin/bash

_basename_without_extension() {
  local _basename
  _basename=$(basename "$1")
  _basename_without_extension_result=${_basename%.*}
}

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

files_amount=$(ls "$FROM_PATH"/*.zip \
  "$FROM_PATH"/*.rar \
  "$FROM_PATH"/*.7z \
  2> /dev/null \
  | wc -l)
echo Amount of files is "$files_amount"

counter=1
for file in "$FROM_PATH"/*.zip "$FROM_PATH"/*.rar "$FROM_PATH"/*.7z; do
  [ -f "$file" ] || continue
  _basename_without_extension "$file"
  dir_name=$_basename_without_extension_result

  next_file_info="$counter. $dir_name"
  if [ $counter == 1 ]; then
    echo "$next_file_info"
  else
    echo -e "\r\033[K$next_file_info"
  fi
  echo -e -n "$counter/$files_amount"
  ((counter=counter+1))
done

echo ""
