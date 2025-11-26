#!/bin/bash
# by Alexsandro - github/dejavudf
# debian/ubuntu/mint

#variables
VAR_DEVICE_IP=""
VAR_DEVICE_NICKNAME=""
VAR_DEVICE_PROFILE="Ping Only"
VAR_XMC_SERVER_IP=192.168.0.249
VAR_XMC_SERVER_PORT=80
VAR_XMC_SERVER_PROTOCOL=http

#FUNC banner
FUNC_BANNER() {
clear
echo "[---------------------------------------------]"
echo "| Script para adicionar devices no XMC via AP |"
echo "| Criado por: Alexsandro Farias               |"
echo "| Versao: 1.0 20/03/2025                      |"
echo "| Compatibilidade: DEBIAN/UBUNTU/MINT         |"
echo "[---------------------------------------------]"
echo "Info: O arquivo lista_devices.txt deve existir no diretorio deste script."
echo "Seu formaTo dever conter uma lista neste formato: NOME;IP"
echo "[---------------------------------------------]"
}

#FUNC login
FUNC_LOGIN() {
echo "Enter Login Information"
echo -n "User: "
read -r VAR_USER
echo -n "Password: "
read -s -r VAR_PASSWORD
echo "Iniciando Script. Por favor, aguarde..."
if [ "$VAR_USER" == "" ] || [ "$VAR_PASSWORD" == "" ]
then
	echo "Erro:"
	echo "Favor executar o script com o usuario e senha. Exemplo: ./NOME_SCRIPT.sh USUARIO SENHA"
	echo "Caso a senha tenha algum caratere especial como !, usar uma barra antes dele \!"
	exit 1
else
	FUNC_CURL
fi
}

#FUNC API via curl
FUNC_CURL() {
cat < ./lista_devices.txt | while read -r VAR_DEVICE
do
	VAR_DEVICE_IP=$(echo "$VAR_DEVICE" | awk -F";" '{print $2}')
	VAR_DEVICE_NICKNAME=$(echo "$VAR_DEVICE" | awk -F";" '{print $1}')
	sleep 2
	curl -s -v --insecure -u $VAR_USER:$VAR_PASSWORD -d "ipAddress=$VAR_DEVICE_IP&profileName=<$VAR_DEVICE_PROFILE>&snmpContext=&nickName=$VAR_DEVICE_NICKNAME" \
	-X POST $VAR_XMC_SERVER_PROTOCOL://$VAR_XMC_SERVER_IP:$VAR_XMC_SERVER_PORT/axis/services/NetSightDeviceWebService/addDeviceEx 2>&1 > /dev/null | tee ./curl_log.log
done
}

FUNC_BANNER
FUNC_LOGIN
