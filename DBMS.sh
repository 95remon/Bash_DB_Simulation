#!/bin/bash
shopt -s extglob
export LC_COLLATE=C
PS3=">select one of the above : "

select choice in "Create Database" "List Databases" "Connect to Database" "Drop Database" "Exit"
do
       case $choice in
	       "Create Database") 
	       . DB_create.sh
		       ;;
	       "List Databases") 
	       . DB_list.sh
		       ;;
	       "Connect to Database") 
		       ;;
	       "Drop Database") 
		       ;;
	       "Exit")
		       break ;;
	       *) echo $choice is not a valid choice
		       ;;
       esac
       done

	       
