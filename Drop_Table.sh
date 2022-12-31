echo
echo -e -n "${yellow}Kindly Enter the Name of Table you want to${clear} ${red}Delete${clear}${yellow} :${clear}"
read TableName
pattern='^[a-zA-Z_][a-zA-Z0-9_]*$'  

while [[ ! $TableName =~ $pattern ]]; 
do
    echo
    echo -e "${red}Name must matches this pattern${clear} ${green} ^[a-zA-Z_][a-zA-Z0-9_]*$ ${clear} "
    echo -e -n "${red}Kindly Enter the Name of Table you want to Delete again :${clear}"
    read TableName

done


TableFile=$(ls 2>> Errors.txt | grep -o "^${TableName}.td$")

if [[ "$TableFile" == "${TableName}.td" ]]; then
    echo -e "${red}Are you sure you want to Delete${clear} ${green}(${TableName})${clear} ${red}?${clear} "

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
                rm ${TableName}.td
                rm .${TableName}.md

                sleep 1
                echo
                echo -e -n "${green}Table ${clear} ${red}${TableName}${clear} ${green}has been${clear} ${red}Deleted${clear} ${green}successfully${clear}" 
                echo
                break
            ;;
            "${YesNoList[1]}")
                break
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
    echo -e "${red}The Table Named${clear} ${green}(${TableName})${clear} ${red}Not Found !${clear} "
    echo
fi

echo 