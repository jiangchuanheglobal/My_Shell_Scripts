#! /usr/local/bin/bash

#
# java auto build helper
#


menu() {
	echo "0 - create project"	
	echo "1 - update project"
	echo "2 - build"	
	echo "3 - run"	
	echo "4 - clean"	
	echo "5 - build & run"
	echo "6 - clean & build & run"
}

create_project() {
	# macro
	local MAIN_TEMPLATE="/Users/jiangchuan/repo/My_Shell_Scripts/java_scripts/main_template.java"
	# project builder
	read -p 'input project name:' PROJ_NAME
	read -p 'input main class name:' CLS_NAME
	read -p 'input package name:' PKG_NAME
	if [ "$CLS_NAME" == "" ]
	then
		CLS_NAME=$PROJ_NAME
	fi

	if [ "$PKG_NAME" == "" ]
	then
		PKG_NAME="com"
	fi

	mkdir ./"$PROJ_NAME"
	cd ./"$PROJ_NAME"
	mkdir src
	cd src
	mkdir "$PKG_NAME"
	cd ./"$PKG_NAME"

	cat "$MAIN_TEMPLATE" > ./"$CLS_NAME".java
	gsed -i "1s/^/package "$PKG_NAME";\n/" ./"$CLS_NAME".java
	gsed -i "s/Main/"$CLS_NAME"/" ./"$CLS_NAME".java
}

update_project() {
	local CONFIG_FILE_PATH='/Users/jiangchuan/repo/My_Ant'
	cp $CONFIG_FILE_PATH/build.xml .
}
menu
read -p 'input option:' option

case $option in 
	0)
		create_project
		;;
	1)
		update_project		
		;;
	2)
		ant build
		;;
	3)
		ant run
		;;
	4)
		ant clean
		;;
	5)
		ant
		;;
	*)
		
esac
