#!/bin/bash

#rm ./logurl.txt

while true
do
	VAR_DATE=$(date '+%Y/%m/%d/%H:%M:%S')
	clear
	echo "Testando URL. Aguarde..."
	if curl -s -o /dev/null -w "%{http_code}" https://apiportal.axa.com.br/portal/ | grep 200
	then
		echo "Data/Hora: $VAR_DATE - Status: Sucesso" >> logurl.txt
	else
		echo "Data/Hora: $VAR_DATE - Status: Erro" >> logurl.txt
	fi
sleep 4
done

