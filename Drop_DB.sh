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
echo -e -n "${yellow}Kindly Enter the Name of DataBase you want to${clear} ${red}Delete${clear}${yellow} :${clear}"
read DBname
pattern='^[a-zA-Z_][a-zA-Z0-9_]*$'  

while [[ ! $DBname =~ $pattern ]]; 
do
    echo
    echo -e "${red}Name must matches this pattern${clear} ${green} ^[a-zA-Z_][a-zA-Z0-9_]*$ ${clear} "
    echo -e -n "${red}Kindly Enter the Name of DataBase you want to Delete again :${clear}"
    read DBname

done

cd DBs

DBFolder=$(ls -d */ 2>> Errors.txt | grep -o "${DBname}/")

if [[ "$DBFolder" == "${DBname}/" ]]; then
    echo -e "${red}Are you sure you want to Delete${clear} ${green}(${DBname})${clear} ${red}?${clear} "

    YesNoList=("Yes" "No")
    while true; 
    do
        echo
        echo -e "${red}Chose (Yes or No) :${clear}" 
        echo
        for ((i=0;i<${#YesNoList[@]};i++)); 
        do 
            string="${yellow}$(($i+1))) ${YesNoList[$i]} ${clear}"
            echo -e $string
        done
        echo
        echo -e -n "${green}select Number #? >${clear} " 
        read Option

        pattern='^[0-9]$'  

        if [[ $Option =~ $pattern ]]; then
            case "${YesNoList[$Option-1]}" in
            "${YesNoList[0]}")
                DBsDeletedFolder=$(ls -a | grep -o ".DeletedDBs")
                if [[ "$DBsDeletedFolder" != ".DeletedDBs" ]]; then
                    mkdir .DeletedDBs
                fi
                currDateTimeZone=$(date "+%F-%T-%Z")
                mv ${DBname} .DeletedDBs/${DBname}${currDateTimeZone}
                echo
                echo -e -n "${green}Date Base${clear} ${red}${DBname}${clear} ${green}has been${clear} ${red}Deleted${clear} ${green}uccessfully${clear}" 
                echo
                break
            ;;
            "${YesNoList[1]}")
                source List_DB.sh
            ;;
            *)
                echo
                echo -e "${red}kindly select number again from 1 or 2${clear}"
                echo
            ;;
            esac
        else
            echo
            echo -e "${red}kindly Enter 1 Number only 1) For Yes 2) For No${clear}"
            echo
            continue
        fi

        
    done



else
    echo
    echo -e "${red}The DataBase Named${clear} ${green}(${DBname})${clear} ${red}Not Found !${clear} "
    echo
fi

cd ..
