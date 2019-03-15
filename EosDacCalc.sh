#!/bin/bash
rm EOSACCTSDATA.csv
COUNTER=0
min=500
EOSDAC=148030547
TELOSDAC=10000000
cat members.csv | grep EOSDAC > membersgood.csv
NUMLINES=$(wc -l < membersgood.csv)
(
while IFS=, read -r col1 col2 col3 col4
do
TOKENS=$(teclos -u https://eos.greymass.com:443 get currency balance eosdactokens ${col1} EOSDAC | rev | cut -c8- | rev )
#echo $TOKENS
#if [[ -n "$TOKENS"  ]]; then
#echo $TOKENS "HOLA"
wt=`bc <<< "$min < $TOKENS"`
if [[ $wt -eq 1 ]]; then
TOKENS1=$(bc <<< "scale=4;($TELOSDAC/$EOSDAC)*$TOKENS")
ACTIVE=$(teclos -u https://api.eosnewyork.io get account ${col1} -j | jq -r  '.permissions[0].required_auth.keys[0].key ')
sleep 0.01
OWNER=$(teclos -u https://eos.greymass.com:443  get account ${col1} -j | jq -r  '.permissions[1].required_auth.keys[0].key ')
NAME=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 5 | head -n 1)
echo "${col1},telosdac${NAME},${OWNER},${ACTIVE},${TOKENS1}"  >> EOSACCTSDATA.csv
	COUNTER=$(($COUNTER+1))
fi
echo $((100*COUNTER/NUMLINES ))
sleep 0.015
done <  membersgood.csv)| whiptail --title 'TELOS DAC' --gauge 'Calculating...' 6 60 0 
echo "Finished"
