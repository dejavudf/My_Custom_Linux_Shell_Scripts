#!/bin/bash
# myclock by dejavudf
# version 1.0 - built 20241018
# Ubuntu/Debian

VAR_HOUR=0
VAR_MINUTE=0
VAR_SECOND=0

while true
do
        clear
        echo "#####################"
        echo "#  Clock: $VAR_HOUR:$VAR_MINUTE:$VAR_SECOND"
        echo "#####################"
        sleep 1
        if [ $VAR_SECOND == 59 ]
        then
                VAR_SECOND=0
                VAR_MINUTE=$((VAR_MINUTE+1))
                if [ $VAR_MINUTE == 59 ]
                then
                        VAR_MINUTE=0
                        if [ $VAR_HOUR == 23 ]
                        then
                                VAR_HOUR=0
                        else
                                VAR_HOUR=$((VAR_HOUR+1))
                        fi
                else
                        :
                fi
        else
                VAR_SECOND=$((VAR_SECOND+1))
        fi
done

