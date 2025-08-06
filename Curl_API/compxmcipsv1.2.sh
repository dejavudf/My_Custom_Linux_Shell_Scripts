#!/bin/bash
# by Alexsandro - github/dejavudf
# v1.2 - 30/05/2025
# debian/ubuntu/mint
#formato arquivo ipsopmon.txt: basta ter os ips dentros do arquivo (areas: services e hosts)
#formato arquivo ipsxmc.csv (arquivo exportado do xmc).

#variables
VAR_XMC_FILE="ipsxmc.csv"
VAR_OPMON_FILE="ipsopmon.txt"
VAR_OUTPUT_FILE="listafinal.txt"

rm "$VAR_OUTPUT_FILE"

cat < ./"$VAR_XMC_FILE" | while read -r VAR_XMC
do
	VAR_IP=$(echo "$VAR_XMC" | awk -F"," '{print $10}')
	VAR_HOST=$(echo "$VAR_XMC" | awk -F"," '{print $4}')
	VAR_LOCAL=$(echo "$VAR_XMC" | awk -F"," '{print $5}')
	clear
	echo 'Working: |'
	clear
	echo 'Working: /'
	clear
	echo 'Working: -'
	clear
	echo 'Working: \'
	if grep -iw "$VAR_IP" ./"$VAR_OPMON_FILE" > /dev/null 2>&1
	then
		continue
	else
		echo "$VAR_IP"",""$VAR_HOST"",""$VAR_LOCAL" >> "$VAR_OUTPUT_FILE"
	fi
done


