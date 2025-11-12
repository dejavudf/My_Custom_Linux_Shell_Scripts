#!/bin/bash
# by dejavudf/alexsandro farias - github.com/dejavudf
# version 1.1 12/11/2025
# bulk background ping with date and time
# debian/ubuntu/mint

#variables
VAR_DATE=$(date '+%Y_%m_%d_%H_%M_%S')
VAR_TIME="30"
VAR_IP=""
VAR_FILE="iplist.txt"
VAR_ADAPTIVE="n"
VAR_EXTENSION="log"

FUNC_BULK_PING() {
for VAR_IP in $(cat "$VAR_FILE")
do
        if [ "$VAR_ADAPTIVE" == "n" ]
        then
                nohup ping -c "$VAR_TIME" "$VAR_IP" | while read -r VAR_PONG; do echo \
                "$(date '+%Y/%m/%d - %H:%M:%S') -> $VAR_PONG";done > "$VAR_DATE""_""$VAR_IP"".""$VAR_EXTENSION" &
        else
                nohup ping -A -c "$VAR_TIME" "$VAR_IP" | while read -r VAR_PONG; do echo \
                "$(date '+%Y/%m/%d - %H:%M:%S') -> $VAR_PONG";done > "$VAR_DATE""_""$VAR_IP"".""$VAR_EXTENSION" &
        fi
done
}

FUNC_BULK_PING
