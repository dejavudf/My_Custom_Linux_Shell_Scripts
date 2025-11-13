#!/bin/bash
# by alexsandro
# compact and backup files and folders (zip)

VAR_DT=$(date '+Date%d_%m_%Y_Hour%H_%M_%S')

clear
echo "Compacting repositories. Wait..."
tar -zcvf ./bck_yml_net/"$VAR_DT""bck_yml_net.tgz" ./*.txt ./scripts ./*.sh ./tests
if [ $? == 0 ]
then
        echo "Success: compact and backup completed"
else
        echo "Error: compact and backup not completed"
fi
exit 0
