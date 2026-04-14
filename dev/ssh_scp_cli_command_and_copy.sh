#!/bin/bash

for VAR_IP in $(cat ip.txt)
do
        if sshpass -p password scp ./$1.txt user@$VAR_IP:/usr/local/tmp/$1.xsf > "copy.log"
        then
                echo "$VAR_IP - Success" > success_copy.txt
        else
                echo "$VAR_IP - Failure" > failure_copy.txt
        fi
done


#!/bin/bash

for VAR_IP in $(cat ip.txt)
do
        if sshpass -p password ssh user@$VAR_IP -o RemoteCommand=$1 > "exec.log"
        then
                echo "$VAR_IP - Success" > success_exec.txt
        else
                echo "$VAR_IP - Failure" > failure_exec.txt
        fi
        sleep 120
done

