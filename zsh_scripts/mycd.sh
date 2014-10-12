#! /bin/zsh
cd $1
retcode=$(echo $?) 
if [ $retcode -ne 0 ]
then
	autojump $1
fi
