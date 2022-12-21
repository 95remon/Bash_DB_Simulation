#!/bin/bash
. naming_check.sh $*
if [ $res = "valid" ]
then
    DB_dir=databases/$*
    if [ -d $DB_dir ] 
    then
        exist="true"
    else
        exist="false"
    fi
fi
