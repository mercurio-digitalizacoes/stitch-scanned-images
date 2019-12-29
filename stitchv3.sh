#!/bin/bash

pto=$1
counter=1
FOV=10
Prefix="result"
first=true
filesarray=()

printf 'Iniciando stitch...\n'
for arg; do
  if $first ; then
    first=false
  else
    let 'counter+=1';
    filesarray+=($arg)
  fi  	
done

if [ "$counter" -gt 0 ]; then
  lenses="i1"
  limit=$(($counter-1))
  for j in `seq 2 $limit`; do
    lenses="$lenses,i$j"
  done
  printf 'Lenses: %s\n' "$lenses"

  pto_gen --projection=0 --fov=$FOV -o "$pto.pto" "${filesarray[@]}"
  pto_lensstack -o "$pto.pto" --new-lens "$lenses" "$pto.pto"
  cpfind --celeste -o "$pto.pto" --fullscale --sieve1size 500 --sieve2width 20 --sieve2height 20 --multirow "$pto.pto"
  cpclean -o "$pto.pto" "$pto.pto"
  linefind --lines=100 -o "$pto.pto" "$pto.pto"
  pto_var -o "$pto.pto" --set=y=0,p=0,a=0,b=0,c=0,g=0,t=0,r=0,TrX=0,TrY=0,TrZ=0,d=0,e=0 "$pto.pto"
  linefind --lines=100 -o "$pto.pto" "$pto.pto"
  pto_var -o "$pto.pto" --opt r,TrX,TrY,TrZ,d,e,!r0,!d0,!e0 "$pto.pto"
  autooptimiser -n -o "$pto.pto" "$pto.pto"
  pano_modify  --projection=0 --fov=AUTO --center --canvas=AUTO --crop=AUTO -o "$pto.pto" "$pto.pto"
  hugin_executor --stitching --prefix="$pto" "$pto.pto"
fi
