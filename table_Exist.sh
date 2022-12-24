#!/bin/bash
. /naming_check.sh $*
if [ $res = "valid" ]
then
    table_dir=$DB_dir/$*
    if [ -f $table_dir ] 
    then
        exist="true"
    else
        exist="false"
    fi
fi
