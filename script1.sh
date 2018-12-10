IFS=$'\n' read -d '' -r -a addresses < ./Desktop/Websites.txt
size=${#addresses[*]}

for ((j=0;j<size;j++))
do
	curl -s -o htmlcode$j.txt ${addresses[$j]}
	md5sum htmlcode$j.txt | cut -c -32 > md5string1$j.md5
	if [[ ! -e md5string2$j.md5 ]]
	then 
		echo "${addresses[$j]} INIT"
		cat md5string1$j.md5 > md5string2$j.md5 
	else 
		if [[ $(cat md5string1$j.md5) != $(cat md5string2$j.md5) ]]
		then
			echo "${addresses[$j]}"
			> md5string2$j.md5 
			cat md5string1$j.md5 > md5string2$j.md5 
		fi
	fi
	rm htmlcode$j.txt
	rm md5string1$j.md5
done
