#!/bin/sh

# Find the extent of each series

for i in ????-??.csv; do

  sed 's/\(..:..\) \([AP]M\)/\2 \1/g' "$i"

done | awk -F\\t -v OFS=\\t \
  '{for(i=2;i<=NF;i++){if(a[i]<$i){a[i]=$i}}}END{$1="**** ** **";for(i=2;i<=length(a)+1;i++){$i=a[i]};print}' | 

  sed 's/\([AP]M\) \(..:..\)/\2 \1/g'
