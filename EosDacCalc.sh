#!/bin/bash
rm EOSACCTSDATA.csv
rm membersgood.csv
rm memberstrim.csv
COUNTER=0
min=500
TELOSDAC=20000000
cat members.csv | grep EOSDAC > membersgood.csv
sed -i.bak -e 's/EOSDAC//1' membersgood.csv

while IFS=, read -r col1 col2 col3 col4
do

	wt=`bc <<< "$min < $col2"`
	if [[ $wt -eq 1 ]]; then
		echo "${col1},${col2},${col3},${col4}"  >> memberstrim.csv
	fi
done <  membersgood.csv
NUMLINES=$(wc -l < memberstrim.csv)
EOSDAC=$(awk -F',' '{x+=$2}END{printf "%.2f", x}' memberstrim.csv)
(
while IFS=, read -r col1 col2 col3 col4
do
	TOKENS=${col2}
#echo $TOKENS
#if [[ -n "$TOKENS"  ]]; then
#echo $TOKENS "HOLA"
	wt=`bc <<< "$min < $TOKENS"`
	if [[ $wt -eq 1 ]]; then
		TOKENS1=$(bc <<< "scale=4;($TELOSDAC/$EOSDAC)*$TOKENS")
		ACTIVE=$(teclos -u https://api.eosnewyork.io get account ${col1} -j | jq -r  '.permissions[0].required_auth.keys[0].key ')
		OWNER=$(teclos -u https://eos.greymass.com:443  get account ${col1} -j | jq -r  '.permissions[1].required_auth.keys[0].key ')
		NAME=$(cat /dev/urandom | tr -dc 'a-z1-5' | fold -w 6 | head -n 1)
#NUMBERS=$(cat /dev/urandom | tr -dc '0-9' | fold -w 3 | head -n 1)
		echo "${col1},tlsdac${NAME},${OWNER},${ACTIVE},${TOKENS1}"  >> EOSACCTSDATA.csv
		COUNTER=$(($COUNTER+1))
	fi
	echo $((100*COUNTER/NUMLINES ))
	sleep 0.1
done <  memberstrim.csv)| whiptail --title 'TELOS DAC' --gauge 'Calculating...' 6 60 0 
echo "EOSACCTSDATA.csv generated"
