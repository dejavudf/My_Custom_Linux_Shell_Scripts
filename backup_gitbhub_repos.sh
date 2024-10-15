#!/bin/bash
# by dejavudf
# Github Repository Download and Compact (zip)
VAR_DT=$(date '+Date%d_%m_%Y_Hour%H_%M_%S')
VAR_FILE=""

clear
if [ -f ./gitlist.txt ] || [ ! -r ./gitlist.txt ]
then
        for VAR_FILE in $(cat ./gitlist.txt)
        do
                git clone https://github.com/dejavudf/$VAR_FILE
                if [ $? == 0 ]
                then
                        echo "Success: Repository download completed"
                        mv ./$VAR_FILE ./github-dejavudf/$VAR_FILE
                else
                        echo "Error: Repository download not completed"
                fi
        done
        echo "Compacting Repositories. Wait..."
        tar -zcvf "$VAR_DT""bck_github.tgz" ./github-dejavudf
        if [ $? == 0 ]
        then
                echo "Success: Repositories compact completed"
        else
                echo "Error: Repositories compact not completed"
        fi
else
        echo "Error: File gitlist.txt not found or not readable"
fi
