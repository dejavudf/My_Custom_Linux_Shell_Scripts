#!/bin/bash
#Created by: Alexsandro Farias (gitHub.com/dejavudf)
#Version: 1.0
#Description: backup Extreme Exos Switches Configuration
#Linux version supported: Debian, Ubuntu and Mint

if cd /home/netsight/scripts/bckcores
then

	#variables
	VAR_PASS=$1
	VAR_CMD="show config"
	VAR_USER="teste"
	VAR_DIR="/usr/local/Extreme_Networks/NetSight/appdata/InventoryMgr/configs/cores"
	VAR_DT=$(date '+%Y%m%d');
	VAR_KEY="HostKeyAlgorithms=ssh-rsa,ssh-dss,rsa-sha2-256,rsa-sha2-512"
	VAR_STRICT="StrictHostKeyChecking=accept-new"
	VAR_ALGO="KexAlgorithms=+diffie-hellman-group1-sha1,diffie-hellman-group14-sha1,curve25519-sha256"
	VAR_HOST="HostKeyAlgorithms=ssh-dss,ssh-rsa"
	VAR_FILE="ips.txt"
	VAR_ACE="PubkeyAcceptedKeyTypes=ssh-rsa,ssh-dss,rsa-sha2-256,rsa-sha2-512"
	VAR_RSA="../../sub_rsa_2048_sha1"

	#get random
	VAR_RANDOM=$(gpg --batch --passphrase "$VAR_PASS" -d -q ../random.gpg)

	#script start
	rm ./*.log
	mkdir "$VAR_DIR/$VAR_DT"
	echo Starting Scripts...Wait...
	for VAR_IP in $(cat < $VAR_FILE)
	do
		../random -p $VAR_RANDOM ssh -i $VAR_RSA -o $VAR_KEY -o $VAR_HOST -o $VAR_STRICT -o $VAR_ALGO $VAR_USER@$VAR_IP -o $VAR_ACE -o RemoteCommand="dis cli pag perm"
		if ../random -p $VAR_RANDOM ssh -i $VAR_RSA -o $VAR_KEY -o $VAR_HOST -o $VAR_STRICT -o $VAR_ALGO $VAR_USER@$VAR_IP -o $VAR_ACE -o RemoteCommand="$VAR_CMD" \
		> "$VAR_DIR""/""$VAR_DT""/""$VAR_DT""_""$VAR_IP"_config.cfg
        	then
			if [ -f "$VAR_DIR""/""$VAR_DT""/""$VAR_DT""_""$VAR_IP"_config.cfg ] && [ ! -s "$VAR_DIR""/""$VAR_DT""/""$VAR_DT""_""$VAR_IP"_config.cfg ]
			then
	                	VAR_DT_HR=$(date '+%Y%m%d-%H:%Mh')
				echo "$VAR_IP - Failure - $VAR_DT_HR" >> "$VAR_DT""_"failure.log
			else
				VAR_DT_HR=$(date '+%Y%m%d-%H:%Mh')
				echo "$VAR_IP - Success - $VAR_DT_HR" >> "$VAR_DT""_"success.log
			fi
        	else
			if [ -f "$VAR_DIR""/""$VAR_DT""/""$VAR_DT""_""$VAR_IP"_config.cfg ] && [ ! -s "$VAR_DIR""/""$VAR_DT""/""$VAR_DT""_""$VAR_IP"_config.cfg ]
			then
				VAR_RANDOM=$(gpg --batch --passphrase "$VAR_PASS" -d -q ../random_bck.gpb)
				VAR_USER="teste2"
				../random -p $VAR_RANDOM ssh -i $VAR_RSA -o $VAR_KEY -o $VAR_HOST -o $VAR_STRICT -o $VAR_ALGO $VAR_USER@$VAR_IP -o $VAR_ACE -o RemoteCommand="dis cli pag perm"
				if ../random -p $VAR_RANDOM ssh -i $VAR_RSA -o $VAR_KEY -o $VAR_HOST -o $VAR_STRICT -o $VAR_ALGO $VAR_USER@$VAR_IP -o $VAR_ACE -o RemoteCommand="$VAR_CMD" \
				> "$VAR_DIR""/""$VAR_DT""/""$VAR_DT""_""$VAR_IP"_config.cfg
				then
					if [ -f "$VAR_DIR""/""$VAR_DT""/""$VAR_DT""_""$VAR_IP"_config.cfg ] && [ ! -s "$VAR_DIR""/""$VAR_DT""/""$VAR_DT""_""$VAR_IP"_config.cfg ]
					then
						VAR_DT_HR=$(date '+%Y%m%d-%H:%Mh')
						echo "$VAR_IP - Failure - $VAR_DT_HR" >> "$VAR_DT""_"failure.log
					else
						VAR_DT_HR=$(date '+%Y%m%d-%H:%Mh')
						echo "$VAR_IP - Success - $VAR_DT_HR" >> "$VAR_DT""_"success.log
					fi
				else
						VAR_DT_HR=$(date '+%Y%m%d-%H:%Mh')
		                		echo "$VAR_IP - Failure - $VAR_DT_HR" >> "$VAR_DT""_"failure.log
				fi
			fi
	   	fi
	done
fi
