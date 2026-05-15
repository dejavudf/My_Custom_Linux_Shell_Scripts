#!/bin/bash

VAR_USER=teste
VAR_PASSWORD=$1
VAR_KEY="HostKeyAlgorithms=+ssh-rsa,ssh-dss"
VAR_STRICT="StrictHostKeyChecking=accept-new"
VAR_ALGO="KexAlgorithms=+diffie-hellman-group1-sha1,diffie-hellman-group14-sha1"

cat /dev/null > ~/.bash_history
rm ./*.tmp
rm ./*.cmd
rm ./*.log
for VAR_IP in $(cat ./ips.txt)
do
        if sshpass -p $VAR_PASSWORD ssh -o $VAR_KEY -o $VAR_STRICT -o $VAR_ALGO $VAR_USER@$VAR_IP "dis cli pag perm"
        then
                echo "$VAR_IP - Success" >> success_check.log
                sshpass -p $VAR_PASSWORD ssh -o $VAR_KEY -o $VAR_STRICT -o $VAR_ALGO $VAR_USER@$VAR_IP "show lldp neighbors" > $VAR_IP.tmp
                grep '[0-9]' ./$VAR_IP.tmp | awk '{print $1,$6}' > ./$VAR_IP"_2".tmp
                while read -r VAR_LLDP
                do
                        VAR_PORT=$(echo "$VAR_LLDP" | awk '{print $1}')
                        VAR_DEVICE=$(echo "$VAR_LLDP" | awk '{print $2}')
                        if [[ "$VAR_DEVICE" == "Not-Advertised" ]] || [[ "$VAR_DEVICE" == *"axis"* ]]
                        then
                                VAR_DEVICE="NONE"
                                echo "configure port $VAR_PORT display-string $VAR_DEVICE" >> ./$VAR_IP.cmd
                                echo "configure port $VAR_PORT description-string $VAR_DEVICE" >> ./$VAR_IP.cmd
                        else
                                echo "configure port $VAR_PORT display-string UP_$VAR_DEVICE" >> ./$VAR_IP.cmd
                                echo "configure port $VAR_PORT description-string UPLINK_$VAR_DEVICE" >> ./$VAR_IP.cmd
                        fi
                done < ./$VAR_IP"_2".tmp
                sshpass -p $VAR_PASSWORD scp -o $VAR_KEY -o $VAR_STRICT -o $VAR_ALGO ./$VAR_IP.cmd $VAR_USER@$VAR_IP:/usr/local/tmp/$VAR_IP.xsf
                sshpass -p $VAR_PASSWORD ssh -o $VAR_KEY -o $VAR_STRICT -o $VAR_ALGO $VAR_USER@$VAR_IP "load script /usr/local/tmp/$VAR_IP.xsf"
                sshpass -p $VAR_PASSWORD ssh -o $VAR_KEY -o $VAR_STRICT -o $VAR_ALGO $VAR_USER@$VAR_IP "save config"
        else
                echo "$VAR_IP - Failure" >> failure_check.log
        fi
done
cat /dev/null > ~/.bash_history
rm ./*.tmp
rm ./*.cmd
exit 0
alexsandro@dccsrvprd0113:~/script$
