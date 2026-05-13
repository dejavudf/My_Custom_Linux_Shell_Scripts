#!/bin/bash

VAR_USER=user
VAR_PASSWORD=$1
history -c

rm ./*.log
rm ./*.tmp
for VAR_IP in $(cat ./ips.txt)
do
        if sshpass -p $VAR_PASSWORD ssh $VAR_USER@$VAR_IP -o RemoteCommand="dis cli pag perm"
        then
                echo "$VAR_IP - Success" >> success_check.log
                sshpass -p $VAR_PASSWORD ssh $VAR_USER@$VAR_IP -o RemoteCommand="show lldp neighbors" > $VAR_IP.tmp
                grep '[0-9]' ./$VAR_IP.tmp | awk '{print $1,$6}' > ./$VAR_IP"_2".tmp
                cat ./$VAR_IP"_2".tmp | while read VAR_LLDP
                do
                        VAR_PORT=$(echo "$VAR_LLDP" | awk '{print $1}')
                        VAR_DEVICE=$(echo "$VAR_LLDP" | awk '{print $2}')
                        sshpass -p $VAR_PASSWORD ssh $VAR_USER@$VAR_IP -o RemoteCommand="configure port $VAR_PORT display-string $VAR_DEVICE" >> $VAR_IP.log
                        sshpass -p $VAR_PASSWORD ssh $VAR_USER@$VAR_IP -o RemoteCommand="configure port $VAR_PORT description-string $VAR_DEVICE" >> $VAR_IP.log
                done
        else
                echo "$VAR_IP - Failure" >> failure_check.log
        fi
done
