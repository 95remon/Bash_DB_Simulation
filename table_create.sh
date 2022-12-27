#!/bin/bash
shopt -s extglob
export LC_COLLATE=C

DB_dir=$1
echo ""
echo "enter table name : "
echo ""
read table_name
echo ""
. table_Exist.sh $table_name
if [ $res = "valid" ] 
then
        if [ $exist = "false" ]
        then
                . #(hyb2a fe hna table def)
                touch $table_dir
                echo $first_row >> $table_dir
                echo $second_row >> $table_dir
                echo ""
                echo $table_name table created successfully
                echo ""
        elif [ $exist = "true" ]
        then
                echo ""
                echo $table_name table already exist
                echo ""
        fi
fi
