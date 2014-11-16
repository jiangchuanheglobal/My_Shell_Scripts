#! /bin/zsh

# log system memory info

file="$(date "+%Y%m%d %H:%M:%S").log"
LOG_PATH="/Users/jiangchuan/repo/My_Shell_Scripts/sys_scripts"
top -l 1 -n 20 -o mem > "$LOG_PATH""/$file"
gsed  -i '1, 11d' "$file"
awk '{print $2, $8}' "$file" > tmp && mv tmp "$file"
