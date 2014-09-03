echo "******************************"
android list targets
echo "******************************"
read -p "select target ID by no:" target
read -p "project:" proj
read -p "path:" path
read -p "package:" package
read -p "main activity:" activity

if [ "$target" ==  "" ] 
then
	target=1
fi

if [ "$proj" ==  "" ] 
then
	proj=myAndrProj
fi

if [ "$path" ==  "" ] 
then
	mkdir ./$name
	path=$(pwd)/$proj
fi

if [ "$package" ==  "" ] 
then
	package="com.$name"
else
	package="com.$package"
fi

if [ "$activity" ==  "" ] 
then
	activity=MainActivity
fi

#echo $target $name $path $activity $package
android create project \
		--target $target \
		--name $proj \
		--path $path \
	  --activity $activity \
		--package $package

