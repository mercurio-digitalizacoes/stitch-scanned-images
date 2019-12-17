#!/bin/bash

folder=$1

if [[ -d $folder ]]; then
  for mapname in $folder/*; do
    if [[ -d $mapname ]]; then
      echo $mapname
      python3.6 ~/stitch-scanned-images/stitchv1.py -o "$(basename $mapname)v1.tiff" "$mapname/croped*"
      bash ~/stitch-scanned-images/stitchv2.sh "$(basename $mapname)v2" "$mapname/croped*"
      bash ~/stitch-scanned-images/stitchv3.sh "$(basename $mapname)v3" "$mapname/croped*"
    fi
  done
fi
