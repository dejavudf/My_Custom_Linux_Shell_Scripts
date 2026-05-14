#!/bin/bash

VAR_USER=teste
VAR_PASSWORD=$1
VAR_FIND=$2
VAR_KEY="HostKeyAlgorithms=+ssh-rsa,ssh-dss"
VAR_STRICT="StrictHostKeyChecking=accept-new"
VAR_ALGO="KexAlgorithms=+diffie-hellman-group1-sha1,diffie-hellman-group14-sha1"

history -c
rm ./*.tmp
rm ./*.cmd
rm ./*.log
for VAR_IP in $(cat ./ips.txt)
do
        if sshpass -p $VAR_PASSWORD ssh -o $VAR_KEY -o $VAR_STRICT -o $VAR_ALGO $VAR_USER@$VAR_IP "dis cli pag perm"
        then
                echo "$VAR_IP - Success" >> success_check.log
                sshpass -p $VAR_PASSWORD ssh -o $VAR_KEY -o $VAR_STRICT -o $VAR_ALGO $VAR_USER@$VAR_IP "show port desc" > $VAR_IP.tmp
                cat $VAR_IP.tmp | grep -i $VAR_FIND > ./$VAR_IP"_2".tmp
                while read -r VAR_DESC_FULL
                do
                        VAR_PORT=$(echo "$VAR_DESC_FULL" | awk '{print $1}')
                        VAR_DISP=$(echo "$VAR_DESC_FULL" | awk '{print $2}')
                        VAR_DESC=$(echo "$VAR_DESC_FULL" | awk '{print $3}')
                        if echo "$VAR_DESC_FULL" | grep -i -e "UP_$VAR_FIND" -e "UPLINK_$VAR_FIND"
                        then
                                VAR_DEVICE="NONE"
                                echo "configure port $VAR_PORT display-string $VAR_DEVICE" >> ./$VAR_IP.cmd
                                echo "configure port $VAR_PORT description-string $VAR_DEVICE" >> ./$VAR_IP.cmd
                                sshpass -p $VAR_PASSWORD scp -o $VAR_KEY -o $VAR_STRICT -o $VAR_ALGO ./$VAR_IP.cmd $VAR_USER@$VAR_IP:/usr/local/tmp/$VAR_IP.xsf
                                sshpass -p $VAR_PASSWORD ssh -o $VAR_KEY -o $VAR_STRICT -o $VAR_ALGO $VAR_USER@$VAR_IP "load script /usr/local/tmp/$VAR_IP.xsf"
                                sshpass -p $VAR_PASSWORD ssh -o $VAR_KEY -o $VAR_STRICT -o $VAR_ALGO $VAR_USER@$VAR_IP "save config"
                        fi
                done < ./$VAR_IP"_2".tmp
        else
                echo "$VAR_IP - Failure" >> failure_check.log
        fi
done
history -c
rm ./*.tmp
rm ./*.cmd
exit 0
