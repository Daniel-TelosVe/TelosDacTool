#!/bin/bash
rm ${1}accts.csv
COUNTER=0
AMTTOT=${2}
NUMLINES=$(wc -l < memberstrim.csv)
PERACC=$((AMTTOT/NUMLINES ))
echo $PERACC
while IFS=, read -r col1
do

	echo "${1},tlsdac${NAME},${col1},${col1},${PERACC}"  >> ${1}accts.csv
	COUNTER=$(($COUNTER+1))
	echo $COUNTER


done <  eosdacaccountscheck.csv
