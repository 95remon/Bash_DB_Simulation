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
else
    ColumnsName=(
                `awk -F ";" '
                {
                    print $1
                }' .${TableName}.md`
                )
    ColumnsType=(
                `awk -F ";" '
                {
                    print $2
                }' .${TableName}.md`
                )
    stringPattern="^[0-9a-zA-Z#@_.%$ ]+$"
    intPattern="^[-]{0,1}[0-9]+$"
    recordLine=""
    for (( i = 0 ; i < ${#ColumnsName[@]} ; i++ )); do
        echo
        echo -e -n "${blue}Enter the (${green}${ColumnsName[$i]}${clear}${blue}) value as (${clear}${red} ${ColumnsType[$i]} ${clear})${blue}: ${clear}"
        read ColumnData
        if [[ $i == 0 ]]; then
            if [[ ${ColumnsType[$i]} == "int" ]]; then
                if [[ $ColumnData =~ $intPattern ]]; then
                    isRepeated=`awk -F ";" '
                                BEGIN{
                                    flag=1
                                }
                                {
                                    if( $1 == "'${ColumnData}'" ) {
                                        flag=0
                                    }
                                    
                                }
                                END{
                                    print flag
                                }
                                ' ${TableName}.td`


                    if [[ $isRepeated != 0 ]]; then
                        recordLine="${ColumnData};"
                    else
                        echo
                        echo -e -n "${red}This record has been entered before (first column is PK)${clear}"
                        i=$i-1
                        continue
                    fi
                else
                    echo
                    echo -e -n "${red}The Data is int and shoud matches this pattern ${clear}${green}^[-]{0,1}[0-9]+${clear}"
                    i=$i-1
                    continue
                fi
            elif [[ ${ColumnsType[$i]} == "string" ]]; then
                if [[ $ColumnData =~ $stringPattern ]]; then
                    isRepeated=`awk -F ";" '
                                BEGIN{
                                    flag=1
                                }
                                {
                                    if( $1 == "'${ColumnData}'" ) {
                                        flag=0
                                    }
                                    
                                }
                                END{
                                    print flag
                                }
                                ' ${TableName}.td`


                    if [[ $isRepeated != 0 ]]; then
                        recordLine="${ColumnData};"
                    else
                        echo
                        echo -e -n "${red}This record has been entered before (first column is PK)${clear}"
                        i=$i-1
                        continue
                    fi
                else
                    echo
                    echo -e -n "${red}The Data is int and shoud matches this pattern ${clear}${green}[0-9a-zA-Z#@_.%$ ]+${clear}"
                    i=$i-1
                    continue
                fi
            fi
            
        else
            if [[ ${ColumnsType[$i]} == "int" ]]; then
                if [[ $ColumnData =~ $intPattern ]]; then
                    recordLine+="${ColumnData};"
                else
                    echo
                    echo -e -n "${red}The Data is int and shoud matches this pattern ${clear}${green}^[-]{0,1}[0-9]+${clear}"
                    i=$i-1
                    continue
                fi
            elif [[ ${ColumnsType[$i]} == "string" ]]; then
                if [[ $ColumnData =~ $stringPattern ]]; then
                    recordLine+="${ColumnData};"
                else
                    echo
                    echo -e -n "${red}The Data is int and shoud matches this pattern ${clear}${green}^[0-9a-zA-Z#@_.%$ ]+$ ${clear}"
                    i=$i-1
                    continue
                fi
            fi            
        fi
    done

    echo ${recordLine:0:-1} >> ${TableName}.td
fi