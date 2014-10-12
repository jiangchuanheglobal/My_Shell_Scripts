#! /bin/bash

echo '---------My jekyll auto tool---------'
echo '                         jiangchuan  '
echo '0  -  create site                    '
echo '1  -  run server'
echo '2  -  build'
echo '3  -  run & build'


echo '-------------------------------------'

read -p 'input option:' option

case $option in
	0)
		read -p 'input site name:' name
		jekyll new $name
		;;
	1)
		jekyll serve
		;;
	2)
		jekyll build
		;;
	3)
		jekyll build
		jekyll serve
		;;
	*)

esac


