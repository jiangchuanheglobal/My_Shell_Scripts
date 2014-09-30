#! /bin/bash

# my_checkout.sh

oldest_ID='f4d95b66723cd2a3f3bc9db6956320a8db4703df'

if [ $# -eq 0 ] 
then
	echo -n "You need to specify history"
	exit 0
else 
	git reset --hard $oldest_ID
	git merge master
	git reset --hard $1
fi



