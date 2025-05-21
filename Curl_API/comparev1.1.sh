#!/bin/bash
# by Alexsandro - github/dejavudf
# v1.1 - 21/05/2025
# debian/ubuntu/mint
# compare and list info (ip, host and site) inside file ipsxmc.csv not found inside file ipsopmon.txt
#formato arquivo ipsopmon.txt: basta ter os ips dentros do arquivo (areas: services e hosts)
#formato arquivo ipsxmc.csv (arquivo exportado do xmc).

#variables
VAR_XMC_FILE="ipsxmc.csv"
VAR_OPMON_FILE="ipsopmon.txt"
VAR_OUTPUT_FILE="listafinal.txt"

rm ./listafinal.txt

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
	if grep -i "$VAR_IP" ./"$VAR_OPMON_FILE"
	then
		continue
	else
		echo "$VAR_IP"",""$VAR_HOST"",""$VAR_LOCAL" >> "$VAR_OUTPUT_FILE"
	fi
done
