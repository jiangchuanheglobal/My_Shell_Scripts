SOURCE_PATH=/Users/jiangchuan/repo/My_Android/tabtest/Tabtest/src
DEBUG_PORT=8700
PACKAGE_NAME=com.WRCA.android
ACTIVITY=com.WRCA.android.MainActivity

#LAUNCH_CMD="adb shell am start -e debug true -a android.intent.action.MAIN -c android.intent.category.LAUNCHER -n $PACKAGE_NAME/$ACTIVITY"
#exec $LAUNCH_CMD &
#sleep 3 # wait for the app to start
APP_DEBUG_PORT=$(adb jdwp | tail -1);
adb forward tcp:$DEBUG_PORT jdwp:$APP_DEBUG_PORT
jdb -attach localhost:$DEBUG_PORT -sourcepath $SOURCE_PATH
