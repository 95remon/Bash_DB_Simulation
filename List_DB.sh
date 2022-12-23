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
cd DBs

DataBasesNames=($(ls -d */ 2>> Errors.txt))
echo
for ((i=0;i<${#DataBasesNames[@]};i++)); 
do 
    string="${cyan}$(($i+1))) ${DataBasesNames[$i]:0:-1} ${clear}"
    echo -e $string
done

cd ..