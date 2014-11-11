#! /bin/bash

echo "AccountAuthenticator"
echo "
getIBinder() 
ACTION_AUTHENTICATOR_INTENT"
echo "
AndroidManifest.xml
<intent-filter>
<action android:name="android.accounts.AccountAuthenticator" />
</intent-filter>
<meta-data android:name="android.accounts.AccountAuthenticator"
android:resource="@xml/authenticator" />""
"

echo "
<account-authenticator xmlns:android="http://schemas.android.com/apk/res/android"
    android:accountType="typeOfAuthenticator"
    android:icon="@drawable/icon"
    android:smallIcon="@drawable/miniIcon"
    android:label="@string/label"
    android:accountPreferences="@xml/account_preferences"
 />
 "

 echo " <PreferenceScreen xmlns:android="http://schemas.android.com/apk/res/android">
    <PreferenceCategory android:title="@string/title_fmt" />
    <PreferenceScreen
         android:key="key1"
         android:title="@string/key1_action"
         android:summary="@string/key1_summary">
         <intent
             android:action="key1.ACTION"
             android:targetPackage="key1.package"
             android:targetClass="key1.class" />
     </PreferenceScreen>
 </PreferenceScreen>"
