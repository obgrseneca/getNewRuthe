#!/bin/bash
# fetch new ruthe strips when available

# change into ruthe comic strip safe dir and clean up existing index.html files
cd ~/Bilder/ruthe.de/
rm -f index.html

# get max index of already downloaded ruthe strips
max=0
for i in $(ls *.jpg | cut -d "_" -f 2 | cut -d "." -f 1); do
	if [ $i -gt $max ]; then
		max=$i
	fi
done

# download the ruthe index.html file and get the index of the comic strip
# if this is greater of the max index download all new files
wget http://www.ruthe.de/ 2>&1 > /dev/null
new=$(cat index.html | grep '<img src="cartoons/strip_' | cut -d "<" -f 4 | cut -d "_" -f 2 | cut -d "." -f 1)
if [ $new -gt $max ]; then
	let firstnew=$max+1
	for i in $(seq $firstnew $new); do
		wget http://www.ruthe.de/cartoons/strip_$i.jpg
	done
else
	echo "No new strips"
fi

# clean up and leave ruthe safe dir again
rm -f index.html
cd - 2>&1 > /dev/null
