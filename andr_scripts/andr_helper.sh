echo '-----------------------------------'
echo 'android auto build and testing tool'
echo '             using android & ant'
echo '-----------------------------------'

echo '--------------menu------------'
echo '0  -  create new project'
echo '1  -  update project'
echo '2  -  build debug-apk'
echo '3  -  build release-apk'
echo '4  -  start logcat'
echo '5  -  create AVD'
echo '6  -  launch AVD'
echo '7  -  build & install & run'
echo '8  -  build & install & run & logcat'
echo '9  -  install apk on emulator'
echo '10 -  clean project'
echo '11 -  install apk on device'
echo '12 -  debug program' 
echo '13 -  list AVD'
echo '14 -  delete avd'
echo '15 -  logcat by TAG name'
echo '16 -  copy public libs to currrent project'
echo '17 -  run program'
echo '18 -  build & install & run & logcat by TAG name'

read -p 'input a option:' option
echo 

# global data
andr_scripts_path=~/repo/My_Shell_Scripts/andr_scripts/
# utilities

copyLibs () {
	echo '--------utitlity for copying library to current project---------'
	echo 'list of exist libraries:'
	path=~/repo/My_Android/public_libs
	ls $path
	echo
	read -p 'input library name:' lib
	cp $path/$lib ./libs	
#	cp /opt/tools/android-sdk-macosx/extras/android/support/v4/*.jar ./libs
}
getProjectInfo () {
	PACKAGE_NAME=$(ggrep -oP "(?<=package=\").*(?=\")" AndroidManifest.xml)
	ACTIVITY=$(ggrep -oP "(?<=android:name=\").*(?=\".*android:label=\"@string/app_name)" AndroidManifest.xml)

	echo '-------------project info------------'
	echo "package name:$PACKAGE_NAME"
	echo "activity name:$ACTIVITY"
	echo
}
# main menu functions

launchProgram () {
	getProjectInfo 
	if [ "$ACTIVITY" == "" ]
	then
		echo 'get activity name failed! abort running!'
		exit 0
	fi
	ACTIVITY=$PACKAGE_NAME$ACTIVITY				
	LAUNCH_CMD="adb shell am start -e debug true -a android.intent.action.MAIN -c android.intent.category.LAUNCHER -n $PACKAGE_NAME/$ACTIVITY"
	exec $LAUNCH_CMD &
	
}
debugProgram () {
	SOURCE_PATH=./src
	DEBUG_PORT=8700
	ACTIVITY=com.WRCA.android.MainActivity

	#LAUNCH_CMD="adb shell am start -e debug true -a android.intent.action.MAIN -c android.intent.category.LAUNCHER -n $PACKAGE_NAME/$ACTIVITY"
	#exec $LAUNCH_CMD &
	#sleep 3 # wait for the app to start
	APP_DEBUG_PORT=$(adb jdwp | tail -1);
	adb forward tcp:$DEBUG_PORT jdwp:$APP_DEBUG_PORT
	jdb -attach localhost:$DEBUG_PORT -sourcepath $SOURCE_PATH

}
cleanProject () {
	ant clean
}

listAVD () {
	echo '----------current exist AVD--------'
	android list avd
}
deleteAVD () {
 	listAVD
	echo	
	read -p 'input name:' name
	android delete avd -n $name
}
createProject () {
	read -p "project name:" name
	read -p "path:" path
	read -p "package name:" package
	read -p "default activity:" activity
	android list targets
	echo '-------------------------------'
	read -p "target ID by no:" target

	if [ "$target" ==  "" ] 
	then
		target=1
	fi

	if [ "$name" ==  "" ] 
	then
		name="andr_proj"
	fi

	if [ "$path" ==  "" ] 
	then
		mkdir ./$name
		path=$(pwd)/$name
	fi

	if [ "$package" ==  "" ] 
	then
		package="com.$name"".android"
	else
		package="com.$package"
	fi

	if [ "$activity" ==  "" ] 
	then
		activity="MyActivity"
	fi

	android create project \
		--target $target \
		--name $name \
		--path $path \
		--activity $activity \
		--package $package

	# sed minversion, maxversion, targetversion
}

updateProject() {
	echo '----------------------------'
	echo 'android ant build file generating tool'
	echo '----------------------------'
	echo '1 - android-19'
	echo '2 - android-20'

	read -p 'please specify target no:'  opt

	case $opt in
		1) 
			target='android-19'
			;;
		2) 
			target='android-L'
			;;
		*) 
			echo "Please enter a valid option!"
			exit 0
	esac

	read -p 'please specify project name:' name
	if [ "$name" == "" ]
	then
		name=$(echo ${PWD##*/})
	fi

	read -p 'please specify project path:' path
	if [ "$path" == "" ]
	then
		path=../$name
	fi

	echo
	echo '----------------------------'
	android update project --target $target --name $name --path $path
}

buildDebugAPK () {
	ant debug
}
buildReleaseAPK () {
	ant releaase
}

startLogging () {
	adb logcat -c

	if [ "$1" == "" ]
	then
		adb logcat
	elif [ "$1" == "V" ]
	then
		adb logcat '*:V'
	elif [ "$1" == "D" ] 
	then
		adb logcat '*:D'
	elif [ "$1" == "W" ] 
	then
		adb logcat '*:W'
	elif [ "$1" == "E" ] 
	then
		adb logcat '*:E'
	elif [ "$1" == "F" ] 
	then
		adb logcat '*:F'
	else
		adb logcat | grep "$1"
	fi
}

createAVD () {
	listAVD
	echo
	read -p 'input AVD name:' name
	android create avd -n $name -t android-19 -s QVGA -b x86
	android update avd -n $name 
}
launchAVD () {
	listAVD
	echo
	read -p 'input AVD name:' name
	cmd="emulator -avd $name"
	$cmd& 
}
installAPK () {
	if [ "$1" == "emulator" ]
	then
		echo '----------install on emulator----------'
		#adb -e emulator-5554 install -r ./bin/*-debug.apk
		adb -e install -r ./bin/*-debug.apk
	else
		echo '----------install on device----------'
		adb -d install -r ./bin/*-debug.apk
	fi
}

if [ "$option" == "" ]
then
	option=7
fi

case $option in
	0)
		createProject
		;;
	1)
		updateProject
		;;
	2)
		buildDebugAPK
		;;
	3)
		buildReleaseAPK
		;;
	4)
		startLogging 
		;;
	5)
		createAVD
		;;
	6)
		launchAVD
		;;
	7)
		buildDebugAPK
		installAPK emulator
		launchProgram

		;;
	8)
		# Build and Install and Run and Logcat
		buildDebugAPK
		installAPK emulator
		launchProgram
		startLogging E
		;;
	9)
		installAPK emulator
		;;
	10)
		cleanProject
		;;
	11)
		installAPK device
		;;
	12)
		debugProgram
		;;
	13)
		listAVD
		;;
	14)
		deleteAVD
		;;
	15)
		read -p 'input TAG name:' TAG
		startLogging $TAG 
		;;
	16)
		copyLibs
		;;
	17)
		launchProgram
		;;
	18)
		# Build and Install and Run and Logcat
		buildDebugAPK
		installAPK emulator
		read -p 'input TAG name:' TAG
		launchProgram
		startLogging $TAG
		;;
	*)
		echo 'please enter a valid option!'
		exit 0
esac

