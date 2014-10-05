echo '-----------welcome-----------'
echo ' UB CSE submit script helper '
echo '-----------------------------'
echo '1 - login to timberlake '
echo '2 - transfer file to timberlake'
echo '3 - submit a file at timberlake '
echo '4 - transfer & submit file'
echo '5 - list timberlake files'
read -p 'input a option:' option

ListRemoteFiles () {
	echo
	echo '----list of timberlake files----'
	ssh jiangchu@timberlake.cse.buffalo.edu 'ls -al'
}

case $option in
	1)
		ssh jiangchu@timberlake.cse.buffalo.edu
		;;
	2)
		read -p 'input local file path/name:' local_path
		ssh jiangchu@timberlake.cse.buffalo.edu 'ls'
		exit 0
		read -p 'input timberlake path:' remote_path 
		if [ $local_path -f ]
		then
			scp $local_path jiangchu@timberlake.cse.buffalo.edu:$remote_path 
		else
			echo 'You must input valid local path!'
			exit 0
		fi
		;;
	3)
		;;
	4)
		;;
	5)
		ListRemoteFiles
		;;
	*)
		echo 'you must enter a valid number!'
esac	
