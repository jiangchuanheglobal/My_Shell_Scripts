#! /usr/local/bin/bash

# ---------------------------------
control_flow_loops () {
		# for
		echo "------- for -------"
		echo "for x in "{1...5}" "
		echo "do"
		echo "    ..."
		echo "done"
				
		# while
		echo "-------- while -----"
		echo "while []"
		echo "do"
		echo "    ..."
		echo "done"
		# do while

}
control_flow_conditional () {
	# if
	echo "------------ if ------------"
	echo "if [ condition1 ]"
	echo "then"
	echo "..."
	echo "elif [ condition2 ]" 
	echo "then"
	echo "..."
	echo "elif [ condition3 ]"
	echo "then"
	echo "else"
	echo "..."
	echo "fi"

	# switch
	echo "------------ switch ---------"
	echo "case 'expression' in "
	echo "pattern1)"
	echo "        ..."
	echo "        ;;"
	echo "pattern2)"
	echo "        ..."
	echo "        ;;"
	echo "*)"
	echo "        ..."
	echo "esac"
}
control_flow () {
	echo "1 - loops"
	echo "2 - conditional"
	read -p "option:" opt
	case $opt in
			0)
					;;
			1)
					control_flow_loops
					;;
			2)
					control_flow_conditional
					;;
			*)
					echo "invalid"
	esac
}

# level 0
content () {
	# level 1
	# control flow
		# level 2
		# loops
			# level 3, do not recommend
			# for
			# while
			# do while
		# conditional
	# variable
	# array
	# string
	# file
	# operator
	# I/O 
	# commands
	# comment style
	# debug
	# publish
	echo "1  -  control flow"
	echo "2  -  variable"
	echo "3  -  array"
	read -p "option:" opt

	case $opt in
			0)
					;;
			1)
					control_flow
					;;
			2)
					;;
			*)
	esac
}

# main entry
content

