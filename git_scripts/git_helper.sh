#!/bin/bash
# for reconvery, use git reset --hard 
#

#----------------------------------
# git pull origin
#----------------------------------
echo '-------------------------------'
echo '    git easy handling tool     '
echo '-------------------------------'
echo '0  -  init repo'
echo '1  -  commit'
echo '2  -  push' 
echo '3  -  commit & push'
echo '4  -  add branch' 
echo '5  -  checkout to another branch' 
echo '6  -  add remote repo'
echo '7  -  delete branch'
echo '8  -  merge branch into current'
echo '9  -  list branch'
echo '10 -  reset to previous checkpoint'
echo '11 -  list remote repo'


read -p 'please specify a option:' option
echo

if ! [[ "$option" =~ ^[0-9]+$ ]]
then
	echo "option must be a number!"
	exit 0
fi

gitListbranch () {
	echo '-------------------------------'
	echo 'list of exist branch'
	git branch
	echo '-------------------------------'
}
gitListRemoterepo () {
	echo '-------------------------------'
	echo 'list of remote repo'
	git remote -v
	echo '-------------------------------'
	
}
gitCommit () {
	cur_time="$(date)"
	default_message="commit at "$cur_time
	echo
	echo '-------------------------------'

	if [ $option -eq 1 -o $option -eq 3 ]
	then
		read -p "please input commit message:" message
		if [ "$message" == "" ]
		then
			message=$default_message
		fi
	fi

	git add -A
	git commit -m "$message"
}
gitPush () {
	local curBranch=$(git rev-parse --abbrev-ref HEAD)
	echo '-----push to remote $curBranch branch-----'
	git push origin $curBranch	
}
gitAddbranch () {
	gitListbranch	
	read -p "input your new branch name:"	name
	echo
	if [ "$name" == "" ]
	then
		echo "branch name cannot be empty!"
		exit 0
	fi
	git branch $name
}
gitCheckoutbranch () {
	gitListbranch	
	
	read -p "input branch name:" name
	if [ "$name" == "" ]
	then
		echo "branch name cannot be empty!"
		exit 0
	fi
	git checkout $name
}

gitDeletebranch () {
	gitListbranch	
	read -p "input branch name:" name
	if [ "$name" == "" ]
	then
		echo "branch name cannot be empty!"
		exit 0
	fi
	git branch -D $name
}

gitAddRemoteRepo () {
	read -p "input remote name:" name
	if [ "$name" == "" ]
	then
		echo "branch name cannot be empty!"
		exit 0
	fi
	
	git remote add origin $name
}

gitMergebranch () {
	gitListbranch
	read -p "input branch name:" name
	if [ "$name" == "" ]
	then
		echo "branch name cannot be empty!"
		exit 0
	fi

  git merge $name	
}

gitResetCurrentBranch () {
	read -p "input checkpoint:" checkpoint
	if [ "$checkpoint" == "" ]
	then
		echo "checkpoint cannot be empty!"
		exit 0
	fi

	git reset --hard $checkpoint	
}

case $option in
	0)
		git init
		;;
	1)
		gitCommit	
		;;
	2)
		gitPush
		;;
	3)
		gitCommit
		gitPush
		;;
	4)
		gitAddbranch
		gitListbranch
		;;
	5)
		# checkout to another branch
		gitCheckoutbranch
		;;
	6)
		# add remote repo
		gitAddRemoteRepo
		;;
	7)
		# delete a specfied local branch
		gitDeletebranch		
		gitListbranch
		;;
	8)
		# merge branch
		gitMergebranch
		;;
	9)
		gitListbranch
		;;
	10)
		gitResetCurrentBranch
		;;
	11)
		gitListRemoterepo
		;;
	*)
esac
