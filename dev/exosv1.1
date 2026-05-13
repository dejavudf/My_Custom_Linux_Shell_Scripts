#!/bin/bash

VAR_USER=teste
VAR_PASSWORD=$1

history -c
rm ./*.tmp
rm ./*.cmd
rm ./*.log
for VAR_IP in $(cat ./ips.txt)
do
        if sshpass -p $VAR_PASSWORD ssh -o StrictHostKeyChecking=accept-new $VAR_USER@$VAR_IP "dis cli pag perm"
        then
                echo "$VAR_IP - Success" >> success_check.log
                sshpass -p $VAR_PASSWORD ssh $VAR_USER@$VAR_IP "show lldp neighbors" > $VAR_IP.tmp
                grep '[0-9]' ./$VAR_IP.tmp | awk '{print $1,$6}' > ./$VAR_IP"_2".tmp
                while read -r VAR_LLDP
                do
                        VAR_PORT=$(echo "$VAR_LLDP" | awk '{print $1}')
                        VAR_DEVICE=$(echo "$VAR_LLDP" | awk '{print $2}')
                        echo "configure port $VAR_PORT display-string UP_$VAR_DEVICE" >> ./$VAR_IP.cmd
                        echo "configure port $VAR_PORT description-string UPLINK_$VAR_DEVICE" >> ./$VAR_IP.cmd
                done < ./$VAR_IP"_2".tmp
                sshpass -p $VAR_PASSWORD scp ./$VAR_IP.cmd $VAR_USER@$VAR_IP:/usr/local/tmp/$VAR_IP.xsf
                if [ $? eq 0 ]
                then
                        echo "$VAR_IP - Load Script OK" >> $VAR_IP"_script_ok".log
                else
                        echo "$VAR_IP - Load Script Error" >> $VAR_IP"_script_error".log
                fi
                sshpass -p $VAR_PASSWORD ssh $VAR_USER@$VAR_IP "load script /usr/local/tmp/$VAR_IP.xsf"
                sshpass -p $VAR_PASSWORD ssh $VAR_USER@$VAR_IP "save config"
        else
                echo "$VAR_IP - Failure" >> failure_check.log
        fi
done
history -c
rm ./*.tmp
rm ./*.cmd
exit 0
