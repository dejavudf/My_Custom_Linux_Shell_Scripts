Meu IP Público é:
 177.17.190.4
ubuntu@ubuntu:~$ nano meuip.sh
  GNU nano 4.8                                                                meuip.sh
#!/bin/bash
rm ./meuip.tmp

clear
echo "Checando IP Público. Por Favor, aguarde..."
curl -s https://www.meuip.com.br | grep -i "Meu ip" > ./meuip.tmp
VAR_MEU_IP=$(cat < ./meuip.tmp | grep -i "meu ip é" | awk -F">" '{print $2}' | awk -F"é" '{print $2}' | awk -F"<" '{print $1}')
clear
echo -n "Meu IP Público é:"
echo "$VAR_MEU_IP"
