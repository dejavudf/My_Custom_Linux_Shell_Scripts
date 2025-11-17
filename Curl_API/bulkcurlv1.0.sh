#!/bin/bash
# by dejavudf/alexsandro farias - github.com/dejavudf
# version 1.0 13/11/2025
# bulk background curl with date and hour
# debian/ubuntu/mint

#variables
VAR_TIME="90"
VAR_INTERVAL="15"
VAR_URL=""
VAR_TIMEOUT="5"
VAR_FILE="urllist.txt"
VAR_SCRIPT="curlmon.sh"

#create curl script
touch ./"$VAR_SCRIPT"
chmod u+x ./"$VAR_SCRIPT"
echo '#!/bin/bash' > ./"$VAR_SCRIPT"
echo '# var1=url var2=time var3=interval var4=host' >> ./"$VAR_SCRIPT"
echo 'VAR_COUNT="1"' >> ./"$VAR_SCRIPT"
echo 'while [ "$VAR_COUNT" -le "$2" ]' >> ./"$VAR_SCRIPT"
echo 'do' >> ./"$VAR_SCRIPT"
echo 'curl -s -o /dev/null -w "%{http_code}\n" "$1" | while read -r VAR_CPONG; do echo "$(date '"'"'+%Y/%m/%d - %H:%M:%S'"'"') -> $1 with code $VAR_CPONG";done >> ./$4.log' >> ./"$VAR_SCRIPT"
echo 'sleep "$3"' >> ./"$VAR_SCRIPT"
echo 'done' >> ./"$VAR_SCRIPT"
echo 'exit 0' >> ./"$VAR_SCRIPT"

FUNC_BULK_PING() {
for VAR_URL in $(cat "$VAR_FILE")
do
	VAR_HOST=$(echo "$VAR_URL" | awk -F"/" '{print $3}')
	sudo nohup ./curlmon.sh "$VAR_URL" "$VAR_TIME" "$VAR_INTERVAL" "$VAR_HOST" &
done
}

FUNC_BULK_PING
exit 0
