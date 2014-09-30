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
echo '5  -  create new emulator'
echo '6  -  launch emulator'
echo '7  -  build & install'
echo '8  -  build & install & logcat'
echo '9  -  install apk on emulator'
echo '10 -  clean project'
echo '11 -  install apk on device'
echo '12 -  debug program' 

read -p 'input a option:' option
echo 

# global data
andr_scripts_path=~/repo/My_Shell_Scripts/andr_scripts/
# utilities

# main menu functions
cleanProject () {
	ant clean
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
	adb logcat -C
#	adb logcat | grep $1
}
createEmulator () {
	android create avd -n 1 -t android-L -s QVGA -b x86
}
launchEmulator () {
	cmd="emulator -avd 1"
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
		createEmulator
		;;
	6)
		launchEmulator
		;;
	7)
		buildAndInstall
		;;
	8)
		BuildAndInstallAndLogcat
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
	*)
		echo 'please enter a valid option!'
		exit 0
esac

