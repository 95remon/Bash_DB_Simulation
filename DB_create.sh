#!/bin/bash
echo ""
echo "enter database name : "
echo ""
read DB_name
#check if the DB exist before creation
if [ $res = "valid" ] 
then
        if [ $exist = "false" ]
        then
                mkdir $DB_dir
                echo ""
                echo $DB_name database created successfully
                echo ""
        elif [ $exist = "true" ]
        then
                echo ""
                echo database already exist
                echo ""
        fi
fi
