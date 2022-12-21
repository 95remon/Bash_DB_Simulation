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
echo
echo -e "${red}Main Menu :${clear}" 



DBsFolder=$(ls -d */ | grep "DBs")

if [[ "$DBsFolder" != *"DBs"* ]]; then
  mkdir DBs
fi

MainMenuList=("Create DB" "List DB" "Connect DB" "Drop DB" "Exit")

for ((i=0;i<${#MainMenuList[@]};i++)); do 
  string="${yellow}$(($i+1))) ${MainMenuList[$i]} ${clear}"
  echo -e $string
done
echo
while true; do
  echo -e -n "${green}select Number #? >${clear} " 
  read Option
    case "${MainMenuList[$Option-1]}" in
        "${MainMenuList[0]}")
            source Creat_DB.sh
        ;;
        "${MainMenuList[1]}")
            List_DB
        ;;
        "${MainMenuList[2]}")
            source Connect_DB.sh
        ;;
        "${MainMenuList[3]}")
            source Drop_DB.sh
        ;;
        "${MainMenuList[4]}")
            echo  -e "${MainMenuList[$Option-1]}"
            break
        ;;
        *)
            echo "kindly select number again"
        ;;
    esac
done

