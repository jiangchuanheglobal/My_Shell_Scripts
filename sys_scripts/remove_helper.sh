#! /usr/local/bin/bash

# a useful substition for 'rm' command
# we remove the file/folder by moving it to trash folder
# rather than eternally deleting it.

usage () {
		echo 'Usage:'
		echo 'remove_helper [-iv] file/folder/*.extensions'
}

# global variables
TRASH_PATH=~/.Trash

# main entry
main () {
    if [ $# -eq 0 ]
		then
				usage
				exit 0
		fi

		local arg_counter=-1
		local mode=0 # 0 - default mode, 1 - interactive, 2 - print
		for arg in "$@"
		do
			let ++arg_counter
			if [ $arg_counter -eq 0 ]
			then
					if [ "${arg:0:1}" == "-" ]	
					then
							# check number of args
							if [ $# -eq 1 ]
							then
									usage
									exit 0
							fi

							mode=0
							continue
					fi
			fi

			# 
			if [ -f "$arg" ] || [ -d "$arg" ]
			then
					# test object exists in trash
					if [ -f "$TRASH_PATH/$arg" ] || [ -d "$TRASH_PATH/$arg" ]
					then
							local UNIQUE_SUFFIX="$(date)"
							#mv $TRASH_PATH/"$arg" "$TRASH_PATH/$UNIQUE_SUFFIX_$arg"
							local new_file_name="$UNIQUE_SUFFIX""___""$arg"
							mv $TRASH_PATH/"$arg" $TRASH_PATH/"$new_file_name"
					fi

					if [ -f "$arg" ]
					then
							echo "remove file:$arg"
					else
							echo "remove folder:$arg"
					fi
					mv "$arg" $TRASH_PATH
			else
					echo "$arg is not a valid file/folder!"
			fi
	done
}

# compatability research
main $@
