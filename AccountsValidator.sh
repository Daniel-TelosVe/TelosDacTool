#!/bin/bash
rm ValidatedAccounts.txt
COUNTER=0
while IFS=, read -r col1 col2 col3 col4 col5
do
teclos -u https://testnet.telos.caleos.io get account ${col2}
if [ $? -eq 1 ]; then
	echo "# ${col2},Not created" >> ValidatedAccounts.txt
	echo ""
	COUNTER=$(($COUNTER+1))
	echo $COUNTER
fi

done <  $1
