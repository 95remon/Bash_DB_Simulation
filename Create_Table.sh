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
echo -e -n "${yellow}Kindly Enter the Name of Tabel :${clear}"
read TableName
pattern='^[a-zA-Z_][a-zA-Z0-9_]*$'  

while [[ ! $TableName =~ $pattern ]]; 
do
    echo
    echo -e "${red}Name must matches this pattern ${green} ^[a-zA-Z_][a-zA-Z0-9_]*$ ${clear} ${clear} "
    echo -e -n "${red}Kindly Enter the Name of Table again :${clear}"
    read TableName
done

TableFile=$(ls *.td 2>> Errors.txt | grep -o "${TableName}/")

if [[ "$TableFile" != "${TableName}.td" ]]; then
    
    echo
    echo -e -n "${green}Kindly Enter the Number of Columns:${clear}"
    read NumOfColumns

    pattern='^[2-9][0-9]*$'  

    while [[ ! $NumOfColumns =~ $pattern ]]; 
    do
        echo
        echo -e "${red}Name must matches this pattern ${green} ^[2-9][0-9]*$ ${clear} ${clear} "
        echo -e -n "${red}Kindly Enter the Number of Columns again :${clear}"
        read NumOfColumns
    done

    touch ${TableName}.tb
    touch .${TableName}.md


    for (( i = 1; i <= $NumOfColumns; i++ )) 
    do

        echo
        echo -e -n "${green}Kindly Enter the Name of Column ${clear}${magenta}#${i}${clear} ${green}:${clear}"
        read ColName

        

        pattern='^[a-zA-Z_][a-zA-Z0-9_]*$'   

        while [[ ! $ColName =~ $pattern ]]; 
        do
            echo
            echo -e "${red}Name must matches this pattern ${green} ^[a-zA-Z_][a-zA-Z0-9_]*$ ${clear} ${clear} "
            echo -e -n "${red}Kindly Enter the Name of Column ${clear}${magenta}#${i}${clear} ${green}:${clear}"
            read ColName
        done
        
        echo
        echo -e -n "${green}Kindly Enter the Type( ${clear}${blue}int${clear} / ${blue}string${clear}${green} ) of Column ${clear}${magenta}#${i}${clear} ${green}:${clear}"
        read ColType

        pattern='(int)|(string)'   

        while [[ ! $ColType =~ $pattern ]]; 
        do
            echo
            echo -e "${red}Type must matches this pattern ${green} (int)|(string) ${clear} ${clear} "
            echo -e -n "${red}Kindly Enter the Type of Column ${clear}${magenta}#${i}${clear} ${green}:${clear}"
            read ColType
        done
        ColumnsArray[i]=$ColName


        if [[ $i == 1 ]]; then
            echo "$ColName;$ColType" >> .${TableName}.md
        else
            bool=`awk -F ";" '
            BEGIN{
                flag=1
            }
            {
                if( $1 == "'$ColName'" ) {
                    flag=0
                }
                
            }
            END{
                print flag
            }
            ' .${TableName}.md`

            if [[ $bool != 0 ]]; then
                echo "$ColName;$ColType" >> .${TableName}.md
            else
                echo
                echo -e "${red}You used this name before ${clear}"
                echo 
                i=$i-1
                continue
            fi

        fi
        
        
        
    done

else
    echo
    echo -e -n "${red}Tabele (${TableName}) Already Exists ${clear}"
    echo
fi
    