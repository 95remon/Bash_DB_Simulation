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
    ColumnsType=(
                `awk -F ";" '
                {
                    print $2
                }' .${TableName}.md`
                )
    echo
    echo -e -n "${green}Table ${clear}${blue}( ${TableName} )${clear}${green} column names :${clear}"
    echo
    for ((i=0;i<${#ColumnsName[@]};i++)); 
    do 
        string="${yellow}$(($i+1))) ${ColumnsName[$i]} ${clear}"
        echo -e $string
    done

    j=0
    ColumnNeededUpdate=""
    ColumnNewValue=""
    WhereColumn=""
    WhereValue=""
    while ((j<4));
    do
        if ((j==0)); then
            echo
            echo -e -n "${green}Write the column needed to update >${clear} " 
            read cnu

            pattern='^[a-zA-Z_][a-zA-Z0-9_]*$'   

            while [[ ! $cnu =~ $pattern ]]; 
            do
                echo
                echo -e "${red}Name must matches this pattern ${green} ^[a-zA-Z_][a-zA-Z0-9_]*$ ${clear} ${clear} "
                echo -e -n "${red}Kindly Enter the Name of Column again ${green}:${clear}"
                read cnu
            done

            if [[  "${ColumnsName[*]}" =~ "${cnu}" ]]; then
                ColumnNeededUpdate=$cnu
                j=$j+1
            else
                echo
                echo -e "${red} You have entered wrong column Name, Try again${clear} "
                continue
            fi
            

        elif ((j==1)); then
            element=$ColumnNeededUpdate
            index=-1
            
            for i in "${!ColumnsName[@]}";
            do
                if [[ "${ColumnsName[$i]}" == "${element}" ]];
                then
                    index=$i
                    break
                fi
            done
            DataTypeOfColumn=${ColumnsType[$index]}

            echo
            echo -e -n "${blue}Enter the (${green}${ColumnNeededUpdate}${clear}${blue}) value as (${clear}${red} ${DataTypeOfColumn} ${clear})${blue}: ${clear}"
            read ColumnData
            if [[ $index == 0 ]]; then
                if [[ ${DataTypeOfColumn} == "int" ]]; then
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
                            ColumnNewValue=$ColumnData
                            j=$j+1
                        else
                            echo
                            echo -e -n "${red}This record has been entered before (first column is PK)${clear}"
                            
                            continue
                        fi
                    else
                        echo
                        echo -e -n "${red}The Data is int and shoud matches this pattern ${clear}${green}^[-]{0,1}[0-9]+${clear}"
                        
                        continue
                    fi
                elif [[ ${DataTypeOfColumn} == "string" ]]; then
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
                            ColumnNewValue=$ColumnData
                            j=$j+1
                        else
                            echo
                            echo -e -n "${red}This record has been entered before (first column is PK)${clear}"
                            
                            continue
                        fi
                    else
                        echo
                        echo -e -n "${red}The Data is string and shoud matches this pattern ${clear}${green}[0-9a-zA-Z#@_.%$ ]+${clear}"
                        
                        continue
                    fi
                fi
                
            else
                

                stringPattern="^[0-9a-zA-Z#@_.%$ ]+$"
                intPattern="^[-]{0,1}[0-9]+$"

                if [[ ${DataTypeOfColumn} == "int" ]]; then
                    if [[ $ColumnData =~ $intPattern ]]; then
                        ColumnNewValue=$ColumnData
                        j=$j+1
                    else
                        echo
                        echo -e "${red}Value must matches this pattern ${green} ^[-]{0,1}[0-9]+$ ${clear} "
                        continue
                    fi
                elif [[ ${DataTypeOfColumn} == "string" ]]; then
                    if [[ $ColumnData =~ $stringPattern ]]; then
                        ColumnNewValue=$ColumnData
                        j=$j+1
                    else
                        echo
                        echo -e -n "${red}The Data is int and shoud matches this pattern ${clear}${green}^[0-9a-zA-Z#@_.%$ ]+$ ${clear}"
                        continue
                    fi
                fi         
            fi




                 

        elif ((j==2)); then


            echo
            echo -e -n "${green}Write the Where column >${clear} " 
            read whc

            pattern='^[a-zA-Z_][a-zA-Z0-9_]*$'   

            while [[ ! $whc =~ $pattern ]]; 
            do
                echo
                echo -e "${red}Name must matches this pattern ${green} ^[a-zA-Z_][a-zA-Z0-9_]*$ ${clear} ${clear} "
                echo -e -n "${red}Kindly Enter the Name of Where Column ${clear} ${green}:${clear}"
                read whc
            done

            if [[  "${ColumnsName[*]}" =~ "${whc}" ]]; then
                WhereColumn=$whc
                j=$j+1
            else
                echo
                echo -e "${red} You have entered wrong column Name, Try again${clear} "
                continue
            fi

        elif ((j==3)); then

            element=$WhereColumn
            index=-1
            
            for i in "${!ColumnsName[@]}";
            do
                if [[ "${ColumnsName[$i]}" == "${element}" ]];
                then
                    index=$i
                    break
                fi
            done
            DataTypeOfColumn=${ColumnsType[$index]}

            echo
            echo -e -n "${blue}Enter the (${green}${WhereColumn}${clear}${blue}) Where value as (${clear}${red} ${DataTypeOfColumn} ${clear})${blue}: ${clear}"
            read whv

            stringPattern="^[0-9a-zA-Z#@_.%$ ]+$"
            intPattern="^[-]{0,1}[0-9]+$"

            if [[ ${DataTypeOfColumn} == "int" ]]; then
                if [[ $whv =~ $intPattern ]]; then
                    WhereValue=$whv
                    j=$j+1
                else
                    echo
                    echo -e "${red}Value must matches this pattern ${green} ^[-]{0,1}[0-9]+$ ${clear} "
                    continue
                fi
            elif [[ ${DataTypeOfColumn} == "string" ]]; then
                if [[ $whv =~ $stringPattern ]]; then
                    WhereValue=$whv
                    j=$j+1
                else
                    echo
                    echo -e -n "${red}The Data is int and shoud matches this pattern ${clear}${green}^[0-9a-zA-Z#@_.%$ ]+$ ${clear}"
                    continue
                fi
            fi

        fi
    done



    echo " ${ColumnNeededUpdate} ${ColumnNewValue} ${WhereColumn} ${WhereValue} "

    


fi