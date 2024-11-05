#!/bin/bash
# by dejavudf
# Github Repository Download and Compact (zip)
# version 1.0 20240928
# debian/ubunt/mint

VAR_DT=$(date '+Date%d_%m_%Y_Hour%H_%M_%S')
VAR_FILE=""

clear
if [ -f ./gitlist.txt ] || [ ! -r ./gitlist.txt ]
then
        for VAR_FILE in $(cat < ./gitlist.txt)
        do
                echo "Downloading repository. Wait..."
                if git clone https://github.com/dejavudf/"$VAR_FILE"
                then
                        echo "Success: Repository download completed"
                        mv ./"$VAR_FILE" ./github-dejavudf/"$VAR_FILE"
                else
                        echo "Error: Repository download not completed"
                fi
        done
        echo "Compacting repositories. Wait..."
        if tar -zcvf "$VAR_DT""bck_github.tgz" ./github-dejavudf
        then
                echo "Success: Repositories compact completed"
                rm -Rf ./github-dejavudf/./*
        else
                echo "Error: Repositories compact not completed"
        fi
else
        echo "Error: File gitlist.txt not found or not readable"
        exit 1
fi
exit 0


