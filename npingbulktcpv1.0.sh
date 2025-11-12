#!/bin/bash
# by dejavudf/alexsandro farias - github.com/dejavudf
# version 1.1 12/11/2025
# bulk background ping with date and hour
# debian/ubuntu/mint

#variables
VAR_DATE=$(date '+%Y_%m_%d_%H_%M_%S')
VAR_TIME="5"
VAR_IP=""
VAR_PORT="80"
VAR_FILE="iplist.txt"
VAR_EXTENSION="log"

FUNC_BULK_PING() {
for VAR_IP in $(cat "$VAR_FILE")
do
        sudo nohup nping --tcp -c "$VAR_TIME" -p "$VAR_PORT" "$VAR_IP" | while read -r VAR_NPONG; do echo \
        "$(date '+%Y/%m/%d - %H:%M:%S') -> $VAR_NPONG";done > "$VAR_DATE""_""$VAR_IP"".""$VAR_EXTENSION" &
done
}

FUNC_BULK_PING
