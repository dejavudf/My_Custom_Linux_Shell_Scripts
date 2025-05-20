#!/bin/bash
# by Alexsandro - github/dejavudf
# v1.0 - 20/05/2025
#variables

rm ./listafinal.txt

cat < ./ipsxmc.txt | while read -r VAR_XMC
do
	VAR_IP=$(echo "$VAR_XMC" | awk -v RS='\r\n' -F";" '{print $3}')
	VAR_HOST=$(echo "$VAR_XMC" | awk -F";" '{print $1}')
	VAR_LOCAL=$(echo "$VAR_XMC" | awk -F";" '{print $2}')
	clear
	echo 'Working: |'
	clear
	echo 'Working: /'
	clear
	echo 'Working: -'
	clear
	echo 'Working: \'
	if ! cat ./ipsopmon.txt | grep -i "$VAR_IP"
	then
		echo "$VAR_IP"";""$VAR_HOST"";""$VAR_LOCAL" >> listafinal.txt
	else
		continue
	fi
done
}

