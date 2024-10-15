#!/bin/bash
# by dejavudf
# version 1.0 - 20241015
# backup cisco ios configs files from eve-ng labs

rm -Rf /data/temp/backup_config/*
find ./ -type f | grep -i ".unl" > ./lista.txt
cat ./lista.txt | while read VAR_FILE
do
        VAR_LAB_NAME=$(cat "$VAR_FILE" | grep -i "<lab name=" | awk -F"=\"" '{print $2}' | sed 's\.unl:<lab name\\g' | sed 's\" id\\g')
        VAR_LAB_ID=$(cat "$VAR_FILE" | grep -i "<lab name=" | awk -F"=\"" '{print $3}' | sed 's\" version\\g')
        VAR_NODE=$(cat "$VAR_FILE" | grep -i "<node id=" | awk -F"=\"" '{print $3,$2}' | sed 's\" type \#\g' | sed 's\" name\\g')
        echo "$VAR_NODE" > /tmp/$VAR_LAB_ID.lab
        cat /tmp/$VAR_LAB_ID.lab | while read VAR_LAB_FILE
        do
        VAR_CONFIG_NAME=$(echo "$VAR_LAB_FILE" | awk -F"#" '{print $1}')
        VAR_CONFIG_ID=$(echo "$VAR_LAB_FILE" | awk -F"#" '{print $2}')
        if [ ! -d /data/temp/backup_config/$VAR_LAB_ID ]
        then
                mkdir /data/temp/backup_config/$VAR_LAB_ID
                echo "$VAR_LAB_NAME" > /data/temp/backup_config/$VAR_LAB_ID/$VAR_LAB_ID.txt
        else
                cp /opt/unetlab/tmp/0/$VAR_LAB_ID/$VAR_CONFIG_ID/startup-config /data/temp/backup_config/$VAR_LAB_ID/$VAR_CONFIG_NAME.cfg
        fi
        done
done
exit
