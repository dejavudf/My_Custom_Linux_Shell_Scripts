#!/bin/bash
#VAR_FILE=$(grep -i SW_CP_GME_1 * | awk -F":" '{print $1}')
#cat $VAR_FILE | grep -i "System Type"

#variables
VAR_SLOTS=""
VAR_SERIAIS=""
VAR_COUNT="0"
VAR_COUNT_TOTAL="0"

#
rm ./lista.txt
for VAR_FILE in *.txt
do
        VAR_SLOTS=()
        VAR_SERIAIS=()
        VAR_COUNT="0"
        VAR_SYSNAME=$(cat $VAR_FILE | grep -i "SysName:" | awk '{print $2}')
        for VAR_SLOT in $(cat $VAR_FILE | grep -i ": X" | grep -iv 110 | grep -iv 55 | awk '{print $3}')
        do
                VAR_SLOTS+=("$VAR_SLOT")
                VAR_COUNT=$((VAR_COUNT + 1))
        done
        for VAR_SERIAL in $(cat $VAR_FILE | grep -i "\-00\-" | grep -i boot | awk '{print $4}')
        do
                VAR_SERIAIS+=("$VAR_SERIAL")
        done
        echo "Sysname: $VAR_SYSNAME - Modelos (slots): ${VAR_SLOTS[*]} - Seriais: ${VAR_SERIAIS[*]} -Total de Slots: $VAR_COUNT" >> lista.txt
        VAR_COUNT_TOTAL=$((VAR_COUNT_TOTAL + VAR_COUNT))
done
echo "$VAR_COUNT_TOTAL" >> ./lista.txt
