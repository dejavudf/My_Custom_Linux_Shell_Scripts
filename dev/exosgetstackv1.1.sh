#!/bin/bash
#Created by: Alexsandro Farias (gitHub.com/dejavudf)
#Version: 1.0
#Description: get exos stack info
#Linux version supported: Debian, Ubuntu and Mint
# total SUMMIT: 197
# total SWITCH ENGINE: 378

if cd /home/netsight/scripts/getstackexos
then

	#variables
	VAR_PASS=$1
	VAR_USER="suportenoc"
	VAR_DIR="/usr/local/Extreme_Networks/NetSight/appdata/InventoryMgr/configs/stack"
	VAR_DT=$(date '+%Y%m%d')
	VAR_STRICT="StrictHostKeyChecking=accept-new"
	VAR_ALGO="KexAlgorithms=+diffie-hellman-group1-sha1,diffie-hellman-group14-sha1,curve25519-sha256"
	VAR_ACE="PubkeyAcceptedKeyTypes=ssh-rsa,ssh-dss,rsa-sha2-256,rsa-sha2-512"
        VAR_HOST="HostKeyAlgorithms=ssh-dss,ssh-rsa"
	VAR_RSA="../../sub_rsa_2048_sha1"
	VAR_FILE="ips.txt"
	VAR_SLOTS=""
	VAR_SERIAIS=""
	VAR_COUNT="0"
	VAR_COUNT_TOTAL="0"
	VAR_TIMEOUT="ConnectTimeout=10"

	#get random
	VAR_RANDOM=$(gpg --batch --passphrase "$VAR_PASS" -d -q ../random.gpg)

 	rm ./*.tmp
	rm ./*.log
	for VAR_IP in $(cat ./$VAR_FILE)
	do
	        if ../random -p $VAR_RANDOM ssh -i $VAR_RSA -o $VAR_TIMEOUT -o $VAR_ACE -o $VAR_HOST -o $VAR_STRICT -o $VAR_ALGO $VAR_USER@$VAR_IP "dis cli pag perm"
	        then
	                echo "$VAR_IP - Success" >> ./success_check.log
	                ../random -p $VAR_RANDOM ssh -i $VAR_RSA -o $VAR_TIMEOUT -o $VAR_ACE -o $VAR_HOST -o $VAR_STRICT -o $VAR_ALGO $VAR_USER@$VAR_IP "show system" > ./$VAR_IP.tmp
	        	VAR_SLOTS=()
		        VAR_SERIAIS=()
		        VAR_COUNT="0"
		        VAR_SYSNAME=$(cat ./$VAR_IP.tmp | grep "SysName:" | awk '{print $2}')
		        for VAR_SLOT in $(cat ./$VAR_IP.tmp | grep ":" | grep -e "Slot" -e "Switch" | grep 10-100 | grep -v IMG | awk '{print $3}')
		        do
			                VAR_SLOTS+=("$VAR_SLOT")
			                VAR_COUNT=$((VAR_COUNT + 1))
		        done
		        for VAR_SERIAL in $(cat ./$VAR_IP.tmp | grep ":" | grep -e "Slot" -e "Switch" | grep IMG | awk '{print $4}')
		        do
	        		        VAR_SERIAIS+=("$VAR_SERIAL")
		        done
	        	echo "Sysname: $VAR_SYSNAME - IP: $VAR_IP - Modelos (slots): ${VAR_SLOTS[*]} - Seriais: ${VAR_SERIAIS[*]} - Total de Slots: $VAR_COUNT" >> $VAR_DIR/$VAR_DT"_"exos_stack.txt
		        VAR_COUNT_TOTAL=$((VAR_COUNT_TOTAL + VAR_COUNT))
		else
			echo "$VAR_IP - Failure" >> ./failure_check.log
		fi
	done
	VAR_TOTAL_STACK=$(cat $VAR_DIR/$VAR_DR"_"exos_stack.txt | wc | awk '{print $1}')
	echo "Total de Stacks: $VAR_TOTAL_STACK" >> $VAR_DIR/$VAR_DR"_"exos_stack.txt
	echo "Total de Switches $VAR_COUNT_TOTAL" >> $VAR_DIR/$VAR_DR"_"exos_stack.txt
fi
rm ./*.tmp
rm ./*.log
exit 0

