
TablesNames=($(ls 2>> Errors.txt | grep *.td ))
echo
for ((i=0;i<${#TablesNames[@]};i++)); 
do 
    string="${cyan}$(($i+1))) ${TablesNames[$i]:0:-3} ${clear}"
    echo -e $string
done
echo 