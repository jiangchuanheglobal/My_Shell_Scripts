#! /usr/local/bin/bash
file="$(date "+%Y%m%d %H:%M:%S").log"
top -l 1 -n 20 -o mem > ./"$file"
gsed  -i '1, 11d' "$file"
awk '{print $2, $8}' "$file" > tmp && mv tmp "$file"
