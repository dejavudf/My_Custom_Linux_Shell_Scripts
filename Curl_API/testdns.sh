#!/bin/bash

rm ./logdns.txt
rm ./logdnsfull.txt

while true
do
	VAR_DATE=$(date '+%Y/%m/%d/%H:%M:%S')
	clear
	echo "Testando DNS. Aguarde..."
	if nslookup apigtw.axa.com.br >> ./logdnsfull.txt
	then
		echo "Sucesso!"
		echo "Data/Hora: $VAR_DATE - Status: Sucesso" >> logdns.txt
	else
		echo "Erro!"
		echo "Data/Hora: $VAR_DATE - Status: Erro" >> logdns.txt
	fi
sleep 15
done

