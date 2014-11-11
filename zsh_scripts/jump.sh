#! /bin/bash
#
# local remote
# 0      0
# 0      1
# 1      0
# 1      1
#

# what the fuck!
# this line loads functions of autojump.zsh into current context

function print_usage() {
	echo "quickly jump to a dir"
}

if [ $# -eq 0 ] 
then
	print_usage
else
	cd $1 &> /dev/null
	retcode=$(echo $?)
	if [ $retcode -ne 0 ] 
	then
		DIR=$(autojump $1)
		cd $DIR	
	fi	
	ls -al
fi
