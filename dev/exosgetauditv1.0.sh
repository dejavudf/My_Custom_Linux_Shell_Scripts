#!/bin/bash

cd /home/ubuntu/tmp

VAR_USER=admin
VAR_PASSWORD="teste"
VAR_KEY="HostKeyAlgorithms=+ssh-rsa,ssh-dss"
VAR_STRICT="StrictHostKeyChecking=accept-new"
VAR_ALGO="KexAlgorithms=+diffie-hellman-group1-sha1,diffie-hellman-group14-sha1"

#get password
#echo -n "Digite a senha: "
#read -s VAR_PASSWORD

rm ./*.tmp
rm ./*.log
for VAR_IP in $(cat ./ips.txt)
do
        if sshpass -p $VAR_PASSWORD ssh -o $VAR_KEY -o $VAR_STRICT -o $VAR_ALGO $VAR_USER@$VAR_IP "dis cli pag perm"
        then
                echo "$VAR_IP - Success" >> success_check.log
                sshpass -p $VAR_PASSWORD ssh -o $VAR_KEY -o $VAR_STRICT -o $VAR_ALGO $VAR_USER@$VAR_IP "show cli journal" > $VAR_IP.tmp
                cat $VAR_IP.tmp | grep -i "/" > ./$VAR_IP"_2".tmp
                while read -r VAR_AUDIT
                do
                        VAR_HASH=$(echo -n $VAR_AUDIT | md5sum | awk '{print $1}')
                        if cat ./$VAR_IP.audit | grep -i "$VAR_HASH"
                        then
                                continue
                        else
                                echo "Audit log: $VAR_AUDIT <-> Log Hash: $VAR_HASH" >> ./$VAR_IP.audit
                        fi
                done < ./$VAR_IP"_2".tmp
        else
                echo "$VAR_IP - Failure" >> failure_check.log
        fi
done
rm ./*.tmp
rm ./*.log
