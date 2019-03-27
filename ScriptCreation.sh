#!/bin/bash
#RICHARDPUBKEYSCSV=richard.csv
#DANIELPUBKEYS=daniel.csv
rm createaccounts.sh
mv createaccounts.log createaccounts.log.bak
TECLOS=/opt/Nodes/v1.6.2/build/programs/cleos/cleos
COUNTER=0
NET="0.1000 TLOS"
CPU="0.9000 TLOS"
RAMKBYTES=4
CREATOR="telosdacnode"
cat <<EOF > createaccounts.sh
#!/bin/bash
rm createaccounts.sh
function validate {
if [ \$retval -eq 0 ];then
echo "Account created"
else
echo "Failed creation of \${ACCOUNT}" >> outerrors.log
fi
}
EOF
while IFS=, read -r col1 col2 col3 col4 col5
do
	echo "ACCOUNT=${col2}" >> createaccounts.sh
	echo "${TECLOS} -u http://109.237.25.217:3888 system newaccount --stake-net \"${NET}\" --stake-cpu \"${CPU}\" --buy-ram-kbytes ${RAMKBYTES} ${CREATOR} ${col2} ${col3} ${col4} >> createaccounts.log " >> createaccounts.sh
        echo 'retval=$?' >> createaccounts.sh
	echo 'validate'  >> createaccounts.sh
	echo 'sleep 0.1'  >> createaccounts.sh
	COUNTER=$(($COUNTER+1))
	echo $COUNTER

done <  EOSACCTSDATA.csv
while IFS=, read -r col1 col2 col3 col4 col5
do
	echo "ACCOUNT=${col2}" >> createaccounts.sh
        echo "${TECLOS} -u http://109.237.25.217:3888 system newaccount --stake-net \"${NET}\" --stake-cpu \"${CPU}\" --buy-ram-kbytes ${RAMKBYTES} ${CREATOR} ${col2} ${col3} ${col4} >> createaccounts.log " >> createaccounts.sh
        echo 'retval=$?' >> createaccounts.sh
	echo 'validate'  >> createaccounts.sh
	echo 'sleep 0.1'  >> createaccounts.sh
        COUNTER=$(($COUNTER+1))
        echo $COUNTER
done <  TlosAccts.csv
while IFS=, read -r col1
do
	#NAME=$(cat /dev/urandom | tr -dc 'a-z1-5' | fold -w 6 | head -n 1)
	echo "ACCOUNT=${col2}" >> createaccounts.sh
        echo "${TECLOS} -u http://109.237.25.217:3888 system newaccount --stake-net \"${NET}\" --stake-cpu \"${CPU}\" --buy-ram-kbytes ${RAMKBYTES} ${CREATOR} tlsdac${NAME} ${col3} ${col4} >> createaccounts.log " >> createaccounts.sh
        echo 'retval=$?' >> createaccounts.sh
	echo 'validate'  >> createaccounts.sh
	echo 'sleep 0.1'  >> createaccounts.sh
        COUNTER=$(($COUNTER+1))
        echo $COUNTER
done <  $RICHARDCSV





