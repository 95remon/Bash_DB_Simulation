#! /usr/bin/bash
export LC_COLLATE=C
shopt -s extglob


# Color variables
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
magenta='\033[0;35m'
cyan='\033[0;36m'
# Clear the color after that
clear='\033[0m'

#------------------------------

clear

echo
echo -e -n "${yellow}Kindly Enter the Name of Table :${clear}"
read TableName
pattern='^[a-zA-Z_][a-zA-Z0-9_]*$'  

while [[ ! $TableName =~ $pattern ]]; 
do
    echo
    echo -e "${red}Name must matches this pattern ${clear}${green} ^[a-zA-Z_][a-zA-Z0-9_]*$ ${clear}"
    echo -e -n "${red}Kindly Enter the Name of Table again :${clear}"
    read TableName

done

TableFile=$(ls 2>> Errors.txt | grep -o "^${TableName}.td$")

if [[ "$TableFile" != "${TableName}.td" ]]; then
    echo
    echo -e "${red}Table (${green}${TableName}${clear}${red}) Not Found ! ${clear}"
    echo
else
    echo
    awk -F ";" '{
        print $0
    }' ${TableName}.td
    echo
    echo -e "${green}Table shown ! ${clear}"
    echo
fi