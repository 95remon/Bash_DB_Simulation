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
while true; 
do

    echo
    echo -e -n "${yellow}Kindly Enter the Name of DataBase :${clear}"
    read DBname
    pattern='^[a-zA-Z_][a-zA-Z0-9_]*$'  

    while [[ ! $DBname =~ $pattern ]]; 
    do
        echo
        echo -e "${red}Name must matches this pattern ${green} ^[a-zA-Z_][a-zA-Z0-9_]*$ ${clear} ${clear} "
        echo -e -n "${red}Kindly Enter the Name of DataBase again :${clear}"
        read DBname

    done

    cd DBs
    
    DBFolder=$(ls -d */ 2>> Errors.txt | grep -o "^${DBname}/$")

    if [[ "$DBFolder" != "${DBname}/" ]]; then
        
        echo
        echo -e -n "${yellow}Kindly Enter Password for ${green}(${DBname})${clear} ${yellow}DataBase :${clear}"
        read DBpassword
        pattern='^[0-9a-zA-Z!@#$%^&*()_+-]{6,}$' 

        while [[ ! $DBpassword =~ $pattern ]]; 
        do
            
            echo
            echo -e "${red}Password must matches this pattern${clear} ${green} ^[0-9a-zA-Z!@#$%^&*()_+-]{6,}$ ${clear} ${clear} "
            echo -e -n "${red}Kindly Enter the Password for ${green}(${DBname})${clear} DataBase again :${clear}"
            read DBpassword
            
        done

        EncryptedPassword=$(eval "echo ${DBpassword} | base64")
        mkdir ${DBname}

        DBmetaDataFile=$(ls -a 2>> Errors.txt  | grep -o "^.DataBaseMetaData.txt$")

        if [[ "$DBmetaDataFile" != ".DataBaseMetaData.txt" ]]; then
            touch .DataBaseMetaData.txt
        fi
        currDate=$(date)
        newLine="${DBname};${EncryptedPassword};${USER};${currDate}"

        echo ${newLine} >> .DataBaseMetaData.txt

        echo
        echo -e -n "${green}DataBase (${DBname}) Has been Created Successfully${clear}"
        echo
        cd ..
        break
    else
        echo
        echo -e -n "${red}DataBase (${DBname}) Already Exists ${clear}"
        echo
        cd ..
        continue
    fi

    cd ..
done