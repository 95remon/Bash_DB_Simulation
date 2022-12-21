
DBsFolder=$(ls -d */ | grep "DBs")

if [[ "$DBsFolder" != *"DBs"* ]]; then
  mkdir DBs
fi

cd DBs
MainMenuList=("Create DB" "List DB" "Connect DB" "Drop DB" "Exit")

select Option in "${MainMenuList[@]}"
do
    case $Option in
        "Create DB")
            Creat_DB
        ;;
        "List DB")
            List_DB
        ;;
        "Connect DB")
            Connect_DB
        ;;
        "Drop DB")
            Drop_DB
        ;;
        "Exit")
            cd ..
            exit 0
        ;;
        *)
            echo "kindly select number again"
        ;;
    esac
done

