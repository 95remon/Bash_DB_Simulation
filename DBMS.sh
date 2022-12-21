#!/bin/bash
shopt -s extglob
export LC_COLLATE=C
PS3=">(Main minu)select one of the above : "

select choice in "Create Database" "List Databases" "Connect to Database" "Drop Database" "Exit"
do
       case $choice in
	       "Create Database") 
		       ;;
	       "List Databases") 
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

	       
