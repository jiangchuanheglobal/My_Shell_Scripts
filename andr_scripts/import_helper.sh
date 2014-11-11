#!/usr/local/bin/bash
# echo $str | sed 's,^[^ ]*\.,,'

# TODO: check already import libraries through scanning "import ..."
if [ -f "$1" ]
then
	echo ""
else
	echo "file not exist."
	exit 0
fi

# check android table exist
declare +A andrLib
ret="$(declare -A | grep 'andrLib')"
if [ "$ret" = "" ]
then
	# create a table to store all android classes
	declare -A andrLib
	# import library
	filename="/Users/jiangchuan/repo/My_Shell_Scripts/andr_scripts/impoLib.txt"
	while read line
	do
		value="$line"
		key="${line##*.}"
		andrLib["$key"]="$value"
	done < $filename
fi

# check allLib exist
ret="$(declare -A | grep 'allLib')"
if [ "$ret" != "" ]
then
	declare +A allLib
fi
# create a table to store needed classes
declare -A allLib

# load already import lib info

#echo "${hashandrLib["k"]}"
#for key in ${!hashandrLib[@]}; do something; done
#for value in ${hashandrLib[@]}; do something; done
#echo hashandrLib has ${#hashandrLib[@]} elements


# split line

# preprocess
str="$(cat "$1")"
str="$(echo "$str" | tr '*' " ")"
str="$(echo $str | tr '/' " ")"
#read -A a <<< "$str"

oldIFS="$IFS"
# some trick here
IFS='
'
IFS=$IFS' '
IFS=$IFS'@''('
IFS=$IFS'.'
IFS=$IFS';'
a=($str)

IFS="$oldIFS"

# check each word
for word in "${a[@]}"
do 
	# echo "$word"
	# check each word in source file exist in andrLib
	if [ "$word" != "" ] && [ "${andrLib["$word"]}" != "" ]
	then
		# check alread in import table
		if [ "${allLib["$word"]}" == "" ]
		then
			allLib["$word"]=${andrLib["$word"]}
		fi
	fi
done

# get impLib
declare -A impLib

while read line
do
	val="$(echo $line | grep 'import')"
	if [ "$val" != "" ]
	then
		key="${line##*.}"
		res="$(echo $key | sed 's/;//')"
		impLib["$res"]="$res"
	fi
done < $1

# get missing lib
declare -A misLib
for key in "${!allLib[@]}"
do
	if [ "${impLib["$key"]}" == "" ]
	then
		echo '---------'
		echo "$key"
		echo "import ${allLib["$key"]};"
		misLib["$key"]="import ${allLib["$key"]};"
	fi
done

