#!/bin/bash
shopt -s extglob
export LC_COLLATE=C

DB_dir=$1
echo ""
echo "enter table name : "
echo ""
read table_name
. /table_Exist.sh $table_name
if [ $res = "valid" ] 
then
        if [ $exist = "false" ]
        then
                echo ""
                echo "$table_name does not exist"
                echo ""
        elif [ $exist = "true" ]
        then
                rm $table_dir
                echo ""
                echo "$table_name dropped successfully"
                echo ""
        fi
fi
