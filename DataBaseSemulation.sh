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
echo -e "${cyan}Weclome${clear} ${red}${USER}${clear} ${cyan}To DataBase Semulation Project${clear} " 
echo


DBsFolder=$(ls -d */ 2>> Errors.txt  | grep -o "DBs/")

if [[ "$DBsFolder" != "DBs/" ]]; then
  mkdir DBs
fi

MainMenuList=("Create DB" "List DB" "Connect DB" "Drop DB" "Exit")

while true; 
do
    echo
    echo -e "${magenta}Main Menu :${clear}" 
    echo
    for ((i=0;i<${#MainMenuList[@]};i++)); 
    do 
    string="${yellow}$(($i+1))) ${MainMenuList[$i]} ${clear}"
    echo -e $string
    done
    echo
    echo -e -n "${green}select Number #? >${clear} " 
    read Option

    pattern='^[0-9]$'  

    if [[ $Option =~ $pattern ]]; then
        case "${MainMenuList[$Option-1]}" in
        "${MainMenuList[0]}")
            source Creat_DB.sh
        ;;
        "${MainMenuList[1]}")
            List_DB
        ;;
        "${MainMenuList[2]}")
            source Connect_DB.sh
            break
        ;;
        "${MainMenuList[3]}")
            source Drop_DB.sh
        ;;
        "${MainMenuList[4]}")
            echo
            echo  -e "${magenta}Good Bye ^^${clear}"
            echo
            break
        ;;
        *)
            echo
            echo -e "${red}kindly select number again from 1 to 5${clear}"
            echo
        ;;
        esac
    else
        echo
        echo -e "${red}kindly Enter 1 Number only from 1 to 5${clear}"
        echo
        continue
    fi

    
done

