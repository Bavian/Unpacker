#!/bin/bash

FILES_FILTER="Path = "

while read line; do
  prefix_free_line=${line#"$FILES_FILTER"}
  if [ "$prefix_free_line" != "$1" ]; then
    echo "$prefix_free_line"
  fi
done <<< $(7z l "$1" -slt | grep "$FILES_FILTER")
