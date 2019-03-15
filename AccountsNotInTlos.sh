#!/bin/bash
rm AccNotInTlos.csv
COUNTER=0
while IFS=, read -r col1 col2
do
teclos get account ${col1}
if [ $? -eq 1 ]; then
	echo "${col1}" >> AccNotInTlos.csv
	COUNTER=$(($COUNTER+1))
	echo $COUNTER
fi  

done <  eosdacaccountscheck.csv
