#! /bin/bash
echo "
<manifest>
 <uses-permission android:name=\"android.permission.GET_ACCOUNTS\" />
    <uses-permission android:name=\"android.permission.USE_CREDENTIALS\" />
    <uses-permission android:name=\"android.permission.MANAGE_ACCOUNTS\" />
    <uses-permission android:name=\"android.permission.AUTHENTICATE_ACCOUNTS\" />
    <uses-permission android:name=\"android.permission.INTERNET\" />
    <uses-permission android:name=\"android.permission.WRITE_SETTINGS\" />
    <uses-permission android:name=\"android.permission.READ_SYNC_STATS\" />
    <uses-permission android:name=\"android.permission.READ_SYNC_SETTINGS\" />
    <uses-permission android:name=\"android.permission.WRITE_SYNC_SETTINGS\" />
    <uses-permission android:name=\"android.permission.BROADCAST_STICKY\" />
    <uses-permission android:name=\"android.permission.ACCESS_NETWORK_STATE\" />
    <uses-permission android:name=\"android.permission.READ_PHONE_STATE\" />
    <uses-permission android:name=\"android.permission.RECEIVE_BOOT_COMPLETED\"/>
    <uses-permission android:name=\"android.permission.WAKE_LOCK\"/>
"
