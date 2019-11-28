#!/bin/bash

folder=$1
run=$2
counter=0
FOV=10
Prefix="result"

if [ -d $folder ]; then
  printf 'Iniciando stich do dir %s...\n' $folder
  mkdir "$folder/originals"
  mkdir "$folder/cropd"
  for file in $folder/*; do
    if [[ "$file" == *"md-1_picture_"*".jpg" ]]; then
      numberoffile=$(echo $file| cut -d'_' -f 3)
      convert -crop 3456x2304+1152+768 "$file" "$folder/cropd$numberoffile"
      mv "$file" "$folder/originals/"
      mv "$folder/cropd$numberoffile" "$folder/cropd/"
      let 'counter+=1'
    fi
  done
  if [ "$counter" -gt 0 ]; then
    lenses="i1"
    limit=$(($counter-1))
    for j in `seq 2 $limit`; do
      lenses="$lenses,i$j"
    done
    printf 'Lenses: %s\n' "$lenses"

    pto_gen --projection=0 --fov=$FOV -o "$folder/project0.pto" "$folder/cropd/cropd"*".jpg"
    pto_lensstack -o "$folder/project1.pto" --new-lens "$lenses" "$folder/project0.pto"
    cpfind --celeste -o "$folder/project2.pto" --multirow "$folder/project1.pto"
    cpclean -o "$folder/project3.pto" "$folder/project2.pto"
    linefind -o "$folder/project4.pto" "$folder/project3.pto"
    pto_var -o "$folder/setoptim.pto" --opt r,TrX,TrY,TrZ,d,e,!r0,!d0,!e0 "$folder/project4.pto"
    autooptimiser -n -o "$folder/autoptim.pto" "$folder/setoptim.pto"
    pano_modify  --projection=0 --fov=AUTO --center --canvas=AUTO --crop=AUTO -o "$folder/project.pto" "$folder/autoptim.pto"
    rm "$folder/project0.pto" "$folder/project1.pto" "$folder/project2.pto" "$folder/project3.pto" "$folder/project4.pto" "$folder/autoptim.pto" "$folder/setoptim.pto"

    if [[ "$run" == "run" ]]; then
      hugin_executor --stitching --prefix="$folder/$Prefix" "$folder/project.pto"
    fi
  fi
  printf 'Stich do dir %s: DONE!\n' $folder
fi

