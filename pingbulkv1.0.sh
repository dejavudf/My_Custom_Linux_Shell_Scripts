#!/bin/bash
# by dejavudf - github.com/dejavudf
# version 1.0 07/06/2025
# bulk background ping
# debian/ubuntu/mint

#variables
VAR_DATE=$(date '+%Y_%m_%d_%H_%M_%S')
VAR_TIME="30"
VAR_IP=""
VAR_FILE="iplist.txt"
VAR_ADAPTIVE="y"
VAR_EXTENSION="log"

FUNC_BULK_PING() {
for VAR_IP in $(cat "$VAR_FILE")
do
        if [ "$VAR_ADAPTIVE" == "n" ]
        then
                nohup ping -c "$VAR_TIME" "$VAR_IP" > "$VAR_DATE""_""$VAR_IP"".""$VAR_EXTENSION" &
        else
                nohup ping -A -c "$VAR_TIME" "$VAR_IP" > "$VAR_DATE""_""$VAR_IP"".""$VAR_EXTENSION" &
        fi
done
}

FUNC_BULK_PING
