#!/bin/bash

#variables
VAR_CMD="show config"
VAR_USER="teste"
VAR_DIR="/usr/local/Extreme_Networks/NetSight/appdata/InventoryMgr/configs/cores"
VAR_DT=$(date '+%Y%m%d');
VAR_KEY="HostKeyAlgorithms=+ssh-rsa,ssh-dss,rsa-sha2-256,rsa-sha2-512"
VAR_STRICT="StrictHostKeyChecking=accept-new"
VAR_ALGO="KexAlgorithms=+diffie-hellman-group1-sha1,diffie-hellman-group14-sha1"
VAR_FILE="ips.txt"
VAR_ACE="PubkeyAcceptedKeyTypes=+ssh-rsa,ssh-dss,rsa-sha2-256,rsa-sha2-512"
VAR_RSA="../sub_rsa_2048_sha1"

#script start
rm ./*.log
mkdir "$VAR_DIR/$VAR_DT"
echo Starting Scripts...Wait...
for VAR_IP in $(cat < $VAR_FILE)
do
        ssh -i $VAR_RSA -o $VAR_KEY -o $VAR_STRICT -o $VAR_ALGO $VAR_USER@$VAR_IP -o $VAR_ACE -o RemoteCommand="dis cli pag perm"
        if ssh -i $VAR_RSA -o $VAR_KEY -o $VAR_STRICT -o $VAR_ALGO $VAR_USER@$VAR_IP -o $VAR_ACE -o RemoteCommand="$VAR_CMD" \
        > "$VAR_DIR""/""$VAR_DT""/""$VAR_DT""_""$VAR_IP"_config.cfg
        then
                echo "$VAR_IP - Success" >> "$VAR_DT""_"success.log
        else
                echo "$VAR_IP - Failure" >> "$VAR_DT""_"failure.log
        fi
done
