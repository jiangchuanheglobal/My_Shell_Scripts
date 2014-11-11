#! /bin/bash
#-----------------
# scp auto script
#
#-----------------
# URL="app@107.170.1.252"
# REMOTE_PATH="/home/app"
# -----------------
URL="jiangchu@ubunix.buffalo.edu"
REMOTE_PATH="~/"
# URL="jiangchu@timberlake.cse.buffalo.edu"
# REMOTE_PATH="~/CSE573"


usage() {
	echo "    usage:
	scp_helper [from/to] [file/dir] path/name'

			from/to:
	-s : copy local to remote host 
	-g : copy from remote host to local host
			
			file/dir:
	-f : file
	-d : directory
	"
}

# main entry
case $1 in
	-s)
		# send to remote
		case $2 in
			-f)
				# file
				if [ -f "$3" ]
				then
					scp $3 $URL:$REMOTE_PATH
				else
					echo "error"
					exit 0
				fi
				;;
			-d)
				# dir
				if [ -d $3 ]
				then
					scp -r $3 $URL:$REMOTE_PATH
				else
					echo "error"
					exit 0
				fi
				;;
			*)
				usage;
				;;
		esac
		;;
	-g)
		# get from remote
		case $2 in
			-f)
				# file
				if [ -f $3 ]
				then
					scp $URL:$REMOTE_PATH $3
				else
					echo "error"
					exit 0
				fi
				;;
			-d)
				# dir
				if [ -d $3 ]
				then
					scp -r $URL:$REMOTE_PATH $3
				else
					echo "error"
					exit 0
				fi
				;;
			*)
				usage;
				;;
		esac
		;;
	*)
		usage;
		;;
esac		



