#!/bin/sh

sed '/^$/d'|awk 'NR%2==0{print $1,$4,$5}'|awk '$2!=x||$3!=y{print}{x=$2;y=$3}'

# data$ ../merge-months.sh | ../fixtime.pl | ../summarize.sh
