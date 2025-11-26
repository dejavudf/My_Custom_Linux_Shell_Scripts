#!/bin/bash
# by Alexsandro - github/dejavudf
# v1.0 - 20/05/2025
# debian/ubuntu/mint
# compare and list info (ip, host and site) inside file ipsxmc.csv not found inside file ipsopmon.txt
#formato arquivo ipsopmon.txt: basta ter os ips dentros do arquiov (serviço e host)
#formato arquivo ipsxmc: nome;localidade;IP

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
        if grep -iw "$VAR_IP" ./ipsopmon.txt
        then
                continue
        else
                echo "$VAR_IP"";""$VAR_HOST"";""$VAR_LOCAL" >> listafinal.txt
        fi
done

