#!/bin/bash
#Created by: Alexsandro Farias (gitHub.com/dejavudf)
#Version: 1.0
#Description: backup audit logs from Extreme EXOS Switches
#Linux version supported: Debian, Ubuntu and Mint
# total SUMMIT: 197
# total SWITCH ENGINE: 378

if cd /home/netsight/scripts/bckaudit
then

	#variables
	VAR_PASS=$1
	VAR_USER="suportenoc"
	VAR_DIR="/usr/local/Extreme_Networks/NetSight/appdata/InventoryMgr/configs/audit"
	VAR_DT=$(date '+%Y%m%d')
	VAR_STRICT="StrictHostKeyChecking=accept-new"
	VAR_ALGO="KexAlgorithms=+diffie-hellman-group1-sha1,diffie-hellman-group14-sha1,curve25519-sha256"
	VAR_ACE="PubkeyAcceptedKeyTypes=ssh-rsa,ssh-dss,rsa-sha2-256,rsa-sha2-512"
        VAR_HOST="HostKeyAlgorithms=ssh-dss,ssh-rsa"
	VAR_RSA="../../sub_rsa_2048_sha1"
	VAR_FILE="ips.txt"
	VAR_TIMEOUT=

	#get random
	VAR_RANDOM=$(gpg --batch --passphrase "$VAR_PASS" -d -q ../random.gpg)

	rm ./*.tmp
	rm ./*.log
	for VAR_IP in $(cat ./$VAR_FILE)
	do
	        if ../random -p $VAR_RANDOM ssh -i $VAR_RSA -o $VAR_ACE -o $VAR_HOST -o $VAR_STRICT -o $VAR_ALGO $VAR_USER@$VAR_IP "dis cli pag perm"
	        then
	                echo "$VAR_IP - Success" >> success_check.log
	                ../random -p $VAR_RANDOM ssh -i $VAR_RSA -o $VAR_ACE -o $VAR_HOST -o $VAR_STRICT -o $VAR_ALGO $VAR_USER@$VAR_IP "show cli journal" > $VAR_IP.tmp
	                cat $VAR_IP.tmp | grep -i "/" > ./$VAR_IP"_2".tmp
	                while read -r VAR_AUDIT
	                do
	                        VAR_HASH=$(echo -n $VAR_AUDIT | md5sum | awk '{print $1}')
	                        if cat $VAR_DIR/$VAR_IP"_exos".audit | grep -i "$VAR_HASH"
	                        then
	                                continue
	                        else
	                                echo "Audit log: $VAR_AUDIT <-> Log Hash: $VAR_HASH" >> $VAR_DIR/$VAR_IP"_exos".audit
	                        fi
	                done < ./$VAR_IP"_2".tmp
	        else
	                echo "$VAR_IP - Failure" >> failure_check.log
	        fi
	done
fi
rm ./*.tmp

