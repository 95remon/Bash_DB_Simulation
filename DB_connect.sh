#!/bin/bash
echo ""
echo "enter database name : "
echo ""
read DB_name
echo ""
# check if the DB
. /DB_Exist.sh $DB_name
if [ $res = "valid" ] 
then
        if [ $exist = "false" ]
        then
                echo ""
				echo $DB_name does not exist
				echo ""
        elif [ $exist = "true" ]
        then
			PS3=">($DB_name DB minu) select one of the above : "
			select choice in "Create Table" "List Tables" "Connect to Table" "Drop Table" "Exit"
			do
				case $choice in
					"Create Table") 
						#TABLE_CREATE_FILE
						;;
					"List Tables") 
						#TABLE_LISST_FILE
						;;
					"Connect to Table") 
_						#CONNECT_tABLE_FILE
						;;
					"Drop Table") 
						#table_drop_FILE
						;;
					"Exit")
						PS3=">(Main minu)select one of the above : "
						break ;;
					*) 
						echo ""
						echo $choice is not a valid choice
						;;
				esac
			done
		fi
fi
