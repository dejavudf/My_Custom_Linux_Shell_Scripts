#!/bin/bash

if cd /home/netsight/scripts/chkpoe
then
	 #variables
        VAR_PASS=$1
        VAR_USER="suportenoc"
        VAR_DIR="/usr/local/Extreme_Networks/NetSight/appdata/InventoryMgr/configs/chkpoe"
        VAR_DT=$(date '+%Y%m%d');
        VAR_KEY="HostKeyAlgorithms=ssh-rsa,ssh-dss,rsa-sha2-256,rsa-sha2-512"
        VAR_STRICT="StrictHostKeyChecking=accept-new"
        VAR_ALGO="KexAlgorithms=+diffie-hellman-group1-sha1,diffie-hellman-group14-sha1"
        VAR_FILE="ips.txt"
        VAR_ACE="PubkeyAcceptedKeyTypes=ssh-rsa,ssh-dss,rsa-sha2-256,rsa-sha2-512"

        #get random
        VAR_RANDOM=$(gpg --batch --passphrase "$VAR_PASS" -d -q ../random.gpg)

	rm ./*.tmp
	rm ./*.log
	rm ./*.lldp
	rm ./*.poe
	for VAR_IP in $(cat ./$VAR_FILE)
	do
		if ../random -p $VAR_RANDOM ssh -o $VAR_KEY -o $VAR_ACE -o $VAR_STRICT -o $VAR_ALGO $VAR_USER@$VAR_IP "dis cli pag perm"
		then
			if ../random -p $VAR_RANDOM ssh -o $VAR_KEY -o $VAR_ACE -o $VAR_STRICT -o $VAR_ALGO $VAR_USER@$VAR_IP "show system | include SysName" > $VAR_IP"_sysname".tmp
			then
	        		if ../random -p $VAR_RANDOM ssh -o $VAR_KEY -o $VAR_ACE -o $VAR_STRICT -o $VAR_ALGO $VAR_USER@$VAR_IP "show lldp neighbors" > $VAR_IP"_lldp".tmp
	                	then
					if ../random -p $VAR_RANDOM ssh -o $VAR_KEY -o $VAR_ACE -o $VAR_STRICT -o $VAR_ALGO $VAR_USER@$VAR_IP "show inline-power stats ports" > $VAR_IP"_poe".tmp
					then
						VAR_SYSNAME=$(cat ./$VAR_IP"_sysname".tmp | awk '{print $2}')
						grep '[0-9]' ./$VAR_IP"_lldp".tmp | awk '{print $1,$2,$3,$6}' > ./$VAR_IP"_2".tmp
						cat ./$VAR_IP"_2".tmp | grep -i -e "ge1" -e "ge2" -e "eth" > ./$VAR_IP.lldp
						grep '[0-9]' ./$VAR_IP"_poe".tmp | awk '{print $1,$2}' > ./$VAR_IP.poe
			        	        while read -r VAR_LLDP
	        		        	do
		                		        VAR_PORT=$(echo "$VAR_LLDP" | awk '{print $1}')
		                        		VAR_ID=$(echo "$VAR_LLDP" | awk '{print $2}')
							VAR_PORT_ID=$(echo "$VAR_LLDP" | awk '{print $3}')
							VAR_NAME=$(echo "$VAR_LLDP" | awk '{print $4}')
		        	                	if ! cat ./$VAR_IP.poe | grep -iw "$VAR_PORT delivering"
			        	                then
        			        			echo $VAR_SYSNAME";"$VAR_IP";"$VAR_PORT";"$VAR_ID";"$VAR_PORT_ID";"$VAR_NAME >> ./$VAR_DT"_"injetor.csv
							fi
		        		        done < ./$VAR_IP.lldp
					else
						if ! cat ./failure_check.log | grep -i $VAR_IP
						then
							echo "$VAR_IP - Failure" >> failure_check.log
						fi
					fi
				else
					if ! cat ./failure_check.log | grep -i $VAR_IP
					then
						echo "$VAR_IP - Failure" >> failure_check.log
					fi
				fi
			else
				if ! cat ./failure_check.log | grep -i $VAR_IP
				then
					echo "$VAR_IP - Failure" >> failure_check.log
				fi
			fi
		else
			if ! cat ./failure_check.log | grep -i $VAR_IP
                        then
				echo "$VAR_IP - Failure" >> failure_check.log
			fi
		fi
	done
fi
rm ./*.tmp
rm ./*.lldp
rm ./*.poe
exit 0
