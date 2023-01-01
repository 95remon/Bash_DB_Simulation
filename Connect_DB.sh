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

echo
echo -e -n "${yellow}Kindly Enter the Name of DataBase :${clear}"
read DBname
pattern='^[a-zA-Z_][a-zA-Z0-9_]*$'  

while [[ ! $DBname =~ $pattern ]]; 
do
    echo
    echo -e "${red}Name must matches this pattern ${clear}${green} ^[a-zA-Z_][a-zA-Z0-9_]*$ ${clear} ${clear} "
    echo -e -n "${red}Kindly Enter the Name of DataBase again :${clear}"
    read DBname

done


cd DBs

DBFolder=$(ls -d */ 2>> Errors.txt | grep -o "^${DBname}/$")



while [[ ! "$DBFolder" == "${DBname}/" ]]; 
do
    cd ..
    echo
    echo -e "${red}DataBase Not Found${clear}"
    echo
    echo -e -n "${yellow}Kindly Enter the Name of DataBase :${clear}"
    read DBname
    pattern='^[a-zA-Z_][a-zA-Z0-9_]*$'  

    while [[ ! $DBname =~ $pattern ]]; 
    do
        echo
        echo -e "${red}Name must matches this pattern ${clear}${green} ^[a-zA-Z_][a-zA-Z0-9_]*$ ${clear} ${clear} "
        echo -e -n "${red}Kindly Enter the Name of DataBase again :${clear}"
        read DBname

    done

    cd DBs

    DBFolder=$(ls -d */ 2>> Errors.txt | grep -o "^${DBname}/$")




done
    
cd ${DBname}
echo
echo -e "${green}Connected Successfully to ${clear}${cyan} ${DBname} ${clear}${clear} "
echo


DataBaseMenuList=("List Tables" "Create Table" "Drop Table" "Insert In Table" "Select All" "select From Table" "Delete From Table" "Update Table" "Back")
while true; 
do
    echo -e "${cyan}${DBname}${clear} ${magenta}DataBase Menu : ${clear}"
    echo

    for ((i=0;i<${#DataBaseMenuList[@]};i++)); 
    do 
        string="${yellow}$(($i+1))) ${DataBaseMenuList[$i]} ${clear}"
        echo -e $string
    done

    echo
    echo -e -n "${green}select Number #? >${clear} " 
    read Option

    pattern='^[0-9]$'  

    if [[ $Option =~ $pattern ]]; then
        case "${DataBaseMenuList[$Option-1]}" in
        "${DataBaseMenuList[0]}")
            source ../../List_Tables.sh
        ;;
        "${DataBaseMenuList[1]}")
            source ../../Create_Table.sh
        ;;
        "${DataBaseMenuList[2]}")
            source ../../Drop_Table.sh
        ;;
        "${DataBaseMenuList[3]}")
            source ../../Insert_In_Table.sh
        ;;
        "${DataBaseMenuList[4]}")
            source ../../Select_All.sh
        ;;
        "${DataBaseMenuList[5]}")
            source ../../Select_From_Table.sh
        ;;
        "${DataBaseMenuList[6]}")
            source Delete_From_Table.sh
        ;;
        "${DataBaseMenuList[7]}")
            source ../../Update_Table.sh
        ;;
        "${DataBaseMenuList[8]}")
            cd ../..
            echo
            echo  -e "${magenta}Back to Main Menu ${clear}"
            echo
            source DataBaseSemulation.sh
            break
        ;;
        *)
            echo
            echo -e "${red}kindly select number again from 1 to 9${clear}"
            echo
        ;;
        esac
    else
        echo
        echo -e "${red}kindly Enter 1 Number only from 1 to 9${clear}"
        echo
        continue
    fi

done