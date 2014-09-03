adb -s emulator-5554 logcat -c
if [ $# -eq 0 ]
then
	adb -s emulator-5554 logcat
else
	adb -s emulator-5554 logcat $1
fi
