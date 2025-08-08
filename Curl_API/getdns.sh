#!/bin/bash

#VAR
VAR_CONTADOR=1
VAR_SLEEP=10
VAR_TOTAL=360
VAR_URL="cs-promptx-prd.brazil.communication.azure.com"

rm ./logdns.txt

while [ "$VAR_CONTADOR" -le "30" ]
do
	clear
	echo "Checking DNS: round "$VAR_CONTADOR" of "$VAR_TOTAL""". Please, wait..."
	#google
	dig @8.8.8.8 "$VAR_URL" >> ./logdns.txt
	dig @8.8.4.4 "$VAR_URL" >> ./logdns.txt

	#cloudflare
	dig @1.1.1.1 "$VAR_URL" >> ./logdns.txt
	dig @1.0.0.1 "$VAR_URL" >> ./logdns.txt

	#opendns
	dig @208.67.222.222 "$VAR_URL" >> ./logdns.txt
	dig @208.67.220.220 "$VAR_URL" >> ./logdns.txt

	#quad9
	dig @9.9.9.9 "$VAR_URL" >> ./logdns.txt
	dig @149.112.112.112 "$VAR_URL" >> ./logdns.txt

	#yandex
	dig @77.88.8.8 "$VAR_URL" >> ./logdns.txt
	dig @77.88.8.1 "$VAR_URL" >> ./logdns.txt

	#comodo
	dig @8.26.56.26 "$VAR_URL" >> ./logdns.txt
	dig @8.20.247.20 "$VAR_URL" >> ./logdns.txt
	sleep 10

	#count
	VAR_CONTADOR=$(( "$VAR_CONTADOR" + 1 ))
	sleep "$VAR_SLEEP"
done

cat ./logdns.txt | grep -i "A" | grep IN | grep -iv CNAME | awk '{print $5}' | sort -du > lista_dns.txt


