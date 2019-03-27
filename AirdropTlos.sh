#!/bin/bash
rm TlosAccts.csv
COUNTER=0
min=99
NUMLINES=$(wc -l < 6MSnapshotWithBalances.csv)
(
while IFS=, read -r col1 col2
do
wt=`echo "${min} < ${col2}" | bc`
if [[ $wt -eq 1 ]]; then
	COUNTER=$(($COUNTER+1))
	NAME=$(cat /dev/urandom | tr -dc 'a-z1-5' | fold -w 6 | head -n 1)
	#NUMBERS=$(cat /dev/urandom | tr -dc '0-9' | fold -w 3 | head -n 1)
	OWNER=$(teclos get account ${col1} -j | jq -r ' .permissions[] | select(.perm_name | contains("owner")) | .required_auth.keys[].key')
	ACTIVE=$(teclos get account ${col1} -j | jq -r ' .permissions[] | select(.perm_name | contains("active")) | .required_auth.keys[].key')
	echo "${col1},tlsdac${NAME},${OWNER},${ACTIVE},${col2}" >> TlosAccts.csv
	#echo $COUNTER
fi
echo $((100*COUNTER/NUMLINES ))
done <  6MSnapshotWithBalances.csv)| whiptail --title 'TELOS DAC' --gauge 'Generating New Account names for TLOS' 6 60 0
echo "TlosAccts.csv generated"
