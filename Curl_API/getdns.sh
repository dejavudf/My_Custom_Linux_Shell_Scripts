#!/bin/bash

#VAR
VAR_CONTADOR=1
VAR_SLEEP=10
VAR_TOTAL=30

rm ./logdns.txt

while [ "$VAR_CONTADOR" -le "30" ]
do
	clear
	echo "Checking DNS: round "$VAR_CONTADOR" of "$VAR_TOTAL""". Please, wait..."
	#google
	dig @8.8.8.8 login.microsoftonline.com > ./logdns.txt
	dig @8.8.4.4 login.microsoftonline.com >> ./logdns.txt

	#cloudflare
	dig @1.1.1.1 login.microsoftonline.com >> ./logdns.txt
	dig @1.0.0.1 login.microsoftonline.com >> ./logdns.txt

	#opendns
	dig @208.67.222.222 login.microsoftonline.com >> ./logdns.txt
	dig @208.67.220.220 login.microsoftonline.com >> ./logdns.txt

	#quad9
	dig @9.9.9.9 login.microsoftonline.com >> ./logdns.txt
	dig @149.112.112.112 login.microsoftonline.com >> ./logdns.txt

	#yandex
	dig @77.88.8.8 login.microsoftonline.com >> ./logdns.txt
	dig @77.88.8.1 login.microsoftonline.com >> ./logdns.txt

	#comodo
	dig @8.26.56.26 login.microsoftonline.com >> ./logdns.txt
	dig @8.20.247.20  login.microsoftonline.com >> ./logdns.txt
	sleep 10

	#count
	VAR_CONTADOR=$(( "$VAR_CONTADOR" + 1 ))
	sleep "$VAR_SLEEP"
done

cat ./logdns.txt | grep -i "A" | grep IN | grep -iv CNAME | awk '{print $5}' | sort -du > lista_dns.txt


