#!/bin/bash

folder=$1

if [[ -d $folder ]]; then
  for mapname in $folder/*; do
    if [[ -d $mapname ]]; then
      echo $mapname
      python3.6 ~/stitch-scanned-images/stitch-scanned-images.py -o "$(basename $mapname).tiff" "$mapname/croped*"
      bash ~/stitch-scanned-images/stich.sh "$(basename $mapname)old" "$mapname/croped*"
    fi
  done
fi
