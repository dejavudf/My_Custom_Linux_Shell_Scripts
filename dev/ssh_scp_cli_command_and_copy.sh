#!/bin/bash

for VAR_IP in $(cat ip.txt)
do
        if sshpass -p teste ssh teste@$VAR_IP -o RemoteCommand="show stpd s0 | inc Mode" >> "check.log"
        then
                echo "$VAR_IP - Success" >> success_check.txt
        else
                echo "$VAR_IP - Failure" >> failure_check.txt
        fi
        echo "$VAR_IP" >> ./check.log
done

#!/bin/bash

for VAR_IP in $(cat ip.txt)
do
        if sshpass -p teste scp -o StrictHostKeyChecking=no ./$1.xsf teste@$VAR_IP:/usr/local/tmp/$1.xsf > "copy.log"
        then
                echo "$VAR_IP - Success" >> success_copy.txt
        else
                echo "$VAR_IP - Failure" >> failure_copy.txt
        fi
done


#!/bin/bash

for VAR_IP in $(cat ip.txt)
do
        if sshpass -p teste ssh teste@$VAR_IP -o RemoteCommand="load script /usr/local/tmp/rstp.xsf" > "exec.log"
        then
                echo "$VAR_IP - Success" >> success_exec.txt
        else
                echo "$VAR_IP - Failure" >> failure_exec.txt
        fi
done

done

#!/bin/bash

#variables
VAR_CMD="show configuration"
VAR_USER="teste"
VAR_DIR="/usr/local/Extreme_Networks/NetSight/appdata/InventoryMgr/configs/cores"
VAR_DT=$(date '+%Y%m%d_%H%M%S');
VAR_KEY="HostKeyAlgorithms=+ssh-rsa,ssh-dss"
VAR_STRICT="StrictHostKeyChecking=accept-new"
VAR_ALGO="KexAlgorithms=+diffie-hellman-group1-sha1,diffie-hellman-group14-sha1"
VAR_FILE="ips.txt"

#script start
echo Starting Scripts...Wait...
for VAR_IP in $(cat < $VAR_FILE)
do
        if ssh -o $VAR_KEY -o $VAR_STRICT -o $VAR_ALGO $VAR_USER@$VAR_IP -o RemoteCommand="$VAR_CMD" > "$VAR_DIR/""$VAR_DT""_""$VAR_IP"_config.cfg
        then
                echo "$VAR_IP - Success" >> "$VAR_DT""_"success.txt
        else
                echo "$VAR_IP - Failure" >> "$VAR_DT""_"failure.txt
        fi
done
