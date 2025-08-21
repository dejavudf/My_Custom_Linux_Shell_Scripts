#!/bin/bash

echo "NOME_AP;MAC_AP;PORTA_AP;SWITCH_IP;SWITCH_NOME" > ./lista_extreme.txt
find ./ -type f | grep -i ".txt" | while read -r VAR_FILE
do
	clear
	echo "Lendo arquivo $VAR_FILE. Por favor, aguarde"
        VAR_SWITCH_IP=$(echo $VAR_FILE | awk -F'-' '{print $1}' | awk -F'_20250821' '{print $1}')
	VAR_SWITCH_NOME=$(cat $VAR_FILE | grep -i '\.1 # ' | awk '{print $1}')
	cat $VAR_FILE | grep -i -e "ge1" -e "eth0" | while read -r VAR_VIZINHO
	do
		VAR_AP_MAC=$(echo $VAR_VIZINHO | awk '{print $2}')
		VAR_AP_NOME=$(echo $VAR_VIZINHO | awk '{print $6}')
		VAR_AP_PORTA_UPLINK=$(echo $VAR_VIZINHO | awk '{print $1}')
		if cat $VAR_FILE | grep -i "$VAR_AP_PORTA_UPLINK    searching"
		then
			echo "$VAR_AP_NOME;$VAR_AP_MAC;$VAR_AP_PORTA_UPLINK;$VAR_SWITCH_IP;$VAR_SWITCH_NOME" >> ./lista_extreme.txt
		else
			continue
		fi
	done
done
