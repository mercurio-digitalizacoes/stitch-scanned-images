#!/bin/bash

folder=$1

if [[ -d $folder ]]; then
  for mapname in $folder/*; do
    if [[ -d $mapname ]]; then
      for filename in $mapname/*; do
        b=$(basename $filename)
        path=$(dirname $filename)
        convert -crop 3456x2304+1152+768 "$filename" "$path/croped$b"
      done
    fi
  done
fi
