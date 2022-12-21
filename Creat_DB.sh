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

# cd DBs
echo -e -n "${yellow}Kindly Enter the Name of DataBase :${clear}"
read DBname
pattern='^[a-zA-Z_][a-zA-Z0-9_]*$'  

if [[ $DBname =~ $pattern ]]; then
    echo "matches"
else
    echo "not matches"
fi


