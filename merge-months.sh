#!/bin/sh

for i in ????-??.csv; do
  month=$(basename "$i" .csv)
  
  awk -F\\t -v OFS=\\t "{\$1=sprintf(\"$month-%02d\",\$1);print}" "$i"
done
