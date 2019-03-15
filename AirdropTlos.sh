#!/bin/bash
rm airdropouttlos.csv
COUNTER=0
min=99
while IFS=, read -r col1 col2
do
wt=`echo "${min} < ${col2}" | bc`
if [[ $wt -eq 1 ]]; then
	COUNTER=$(($COUNTER+1))
	NAME=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 5 | head -n 1)
	OWNER=$(teclos get account ${col1} -j | jq -r ' .permissions[] | select(.perm_name | contains("owner")) | .required_auth.keys[].key')
	ACTIVE=$(teclos get account ${col1} -j | jq -r ' .permissions[] | select(.perm_name | contains("active")) | .required_auth.keys[].key')
	echo "telosdac${NAME},${col1},${col2},${OWNER},${ACTIVE}" >> airdropouttlos.csv
	echo $COUNTER
fi
done <  6MSnapshotWithBalances.csv
