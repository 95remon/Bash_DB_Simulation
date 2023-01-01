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
    ColumnsName=(
                `awk -F ";" '
                {
                    print $1
                }' .${TableName}.md`
                )

    for ((i=0;i<${#ColumnsName[@]};i++)); 
    do 
        string="${green}$(($i+1))) ${ColumnsName[$i]} ${clear}"
        echo -e $string
    done

    echo
    echo -e -n "${green}Kindly Enter the Number of Columns you want to sellect:${clear}"
    read NumOfColumns
    echo

    pattern='^[1-9][0-9]*$'  


    while [[ ! $NumOfColumns =~ $pattern ]] || (( $NumOfColumns > ${#ColumnsName[@]} )); 
    do
        
        echo
        echo -e "${red}Name must matches this pattern ${green} ^[2-9][0-9]*$ ${clear} ${clear} "
        echo -e -n "${red}Kindly Enter the Number of Columns again :${clear}"
        read NumOfColumns
        
    done

    

    


    columns=()
    for (( i=1 ; i<=${NumOfColumns} ; i++ ));
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

        if [[  " ${ColumnsName[@]} " =~ " ${ColName} " ]]; then
            columns[$i-1]=${ColName}
        else
            echo
            echo -e "${red} You have entered wrong column Name, Try again${clear} "
            ((i=$i-1))
            continue
        fi

    done


    indexes=()

    for (( i=0 ; i<${NumOfColumns} ; i++ ));
    do
        element=${columns[$i]}
        index=-1
        for j in "${!columns[@]}";
        do
            
            if [[ "${ColumnsName[$j]}" == "${element}" ]];
            then
                ((index=$j+1))
                
                break
            fi
        done
        indexes[$i]=$index
    done


    echo ${indexes[@]}

    for (( i=0 ; i<${#indexes[@]} ; i++ ));
    do
        awk -F ";" '{
            i="'${indexes[i]}'"

            print $i
            
            

        }' ${TableName}.td >> tmp 2>> Errors.txt 
    done
    


fi