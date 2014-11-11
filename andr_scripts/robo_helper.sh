# !/bin/bash
# roboguice usage instruction


printHelp () {
	echo "1  -  showInjectSyntax"
	echo "2  -  showImportRequireLib"
}

showInjectSyntax () {
	echo "
	 @ContentView(R.layout.main)
    class RoboWay extends RoboActivity { 
        @InjectView(R.id.name)             TextView name; 
        @InjectView(R.id.thumbnail)        ImageView thumbnail; 
        @InjectResource(R.drawable.icon)   Drawable icon; 
        @InjectResource(R.string.app_name) String myName; 
        @Inject                            LocationManager loc; 

        public void onCreate(Bundle savedInstanceState) { 
            super.onCreate(savedInstanceState); 
            name.setText( "Hello, " + myName ); 
        } 
    } "
	echo
	echo "remember to replace original super class with <RoboSherlockActivity>"
}

showImportRequireLib () {
	echo "
	import com.github.rtyley.android.sherlock.roboguice.activity.RoboSherlockActivity;
	import com.google.inject.Inject;
	import roboguice.inject.ContentView;
	import roboguice.inject.InjectView;
	"	
}

printHelp

read -p "input your option:" option
case $option in
	1)
		showInjectSyntax
		;;
	2)
		showImportRequireLib
		;;
	*)
esac
