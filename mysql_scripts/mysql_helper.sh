#! /bin/bash
# create table
# CREATE DATABASE GeoHelper;
# USE GeoHelper;
# create table

#---------------------------------------------
# mysql -h host -u user -p pass --execute CMD
#
#---------------------------------------------
statement=""
CREATE_TABLE_FILE=_table.txt

# utitly
executeSQL () {
	if [ "$1" == "" ]
	then
		echo "sql statement cannot be null!"
		exit
	fi

	mysql -u root --execute "$1"
}
printUsage (){
	echo '----------------------------'
	echo '       mysql  helper        '
	echo '----------------------------'
	echo '1  -  show database	        '
	echo '2  -  show table		        '
	echo '3  -  create database       '
	echo '4  -  create table		      '
	echo '5  -  show table content    '
	echo '6  -  drop table            '
	echo '7  -  drop database         '
	echo '8  -  create table from file'
	
}

DropDatabase () {
	showDatabase;
	read -p 'input Database name:' DATABASE
	statement="DROP DATABASE $DATABASE;"
	executeSQL "$statement" 
}
DropTable () {
	showDatabase;
	echo
	read -p 'input Database name:' DATABASE
	statement="USE $DATABASE;""SHOW TABLES;"
	executeSQL "$statement"
	read -p 'input table name:' TBL_NAME
	statement="USE $DATABASE;""DROP TABLE $TBL_NAME;"
	executeSQL "$statement" 
}

showTable (){
	showDatabase;
	echo
	read -p 'input Database name:' DATABASE
	statement="USE $DATABASE;""SHOW TABLES;"
	executeSQL "$statement"
}

showTableContent () {
	showTable
	echo
	read -p 'input Table name:' TBL_NAME
	
	statement="USE $DATABASE;""SHOW FIELDS FROM $TBL_NAME;"
	echo $statement
	executeSQL "$statement"
}
showDatabase() {
	statement="SHOW DATABASES;"
	executeSQL "$statement"
}

SQLHelper (){
	case $1 in
		1)
			showDatabase;
			;;
		2)
			showTable;
			;;
		3)
			createDatabase;
			;;
		4)
			createTable;
			;;
		5)
			showTableContent
			;;
		6)
			DropTable
			;;
		7)
			DropDatabase
			;;
		8)
			createTableFromFile
			;;
		-h)
			printUsage;
			;;
		*)
			echo 'invalid option!'
			printUsage;
	esac
}

createDatabase (){
	read -p 'input database name:' DB_NAME
	if [ "$DB_NAME" == "" ]
	then
		echo 'database cannot be null!'
		exit
	fi
	statement="CREATE DATABASE $DB_NAME;"
	executeSQL "$statement;"
}
createField () {
	echo "--------------------------------------------"
	# message content
	NAME_TYPE="(0-BIT, 1-INT, 2-INTEGER, 3-FLOAT, 4-DOUBLE, 5-TIMESTAMP, \\
	6-CHAR, 7-VARCHAR(256), 8-TEXT, 9-MEDIUMINT)"
	NAME_NULL="(0-NULL, 1-NOT NULL)"
	NAME_AUTO="(0-NOT AUTO, 1-AUTO)"

	# sql argument
	Type=('BIT' 'INT' 'INTEGER' 'FLOAT' 'DOUBLE' 'TIMESTAMP' 'CHAR' 'VARCHAR(256)' 'TEXT' 'MEDIUMINT')
	Null=('NULL' 'NOT NULL')
	AutoIncr=('' 'AUTO_INCREMENT');

	# field name
	read -p "input field name:" SQL_Field
	# type
	read -p "input datatype $NAME_TYPE:" index
	SQL_Type=${Type[index]}
	# NULL
	read -p "input NULL property $NAME_NULL:" index
	SQL_Default=${Null[index]}
	# auto incr
	read -p "input auto increment $NAME_AUTO:" index
	SQL_Extra=${AutoIncr[index]}

	# build string
	FIELD="$SQL_Field ""$SQL_Type "" $SQL_Default"" $SQL_Extra"
}

createTableFromFile () {
	read -p 'input file name:' FILE
	statement=$(cat $FILE)
	executeSQL "$statement"
}

createTable () {   
	showDatabase;
	read -p 'input database name:' DB_NAME
	statement="USE $DB_NAME;"

	read -p 'input Table name:' TBL_NAME
	read -p 'input number of fields:' FIELDS_NUM

	# create each fields
	TBL_FIELDS=''
	for ((i=0; i < $FIELDS_NUM; i++))
	do
		FIELD=''	
		createField
		TBL_FIELDS=$TBL_FIELDS$FIELD","
	done

	# add primary or foreign key
	read -p 'input PRIMARY KEY:' SQL_PKEY

	# foreign key ?
	read -p 'have foreign key[y/n]' ans
	if [ "$ans" == "y" ]
	then
		read -p 'input foreign table:' FTBL
		read -p 'input foreign key:' FKEY
		SQL_FKEY="FOREIGN KEY ($FKEY) REFERENCES $FTBL($FKEY)"
		echo $SQL_FKEY
	fi



	TBL_FIELDS=$TBL_FIELDS"PRIMARY KEY($SQL_PKEY)"
	statement=$statement"CREATE TABLE "$TBL_NAME"($TBL_FIELDS);"
	executeSQL "$statement"

	# save to file in case of modification 
	# allow user to import it next to avoid rundant input
	echo "$statement" > "$TBL_NAME$CREATE_TABLE_FILE"
}

SQLHelper $1
