#!/bin/bash
# Myyoutube to mp4 script by dejavudf
# version 1.0 - built 20241005
# tested and validated on debian/ubuntu/mint

echo "Atualizando yt-dlp. Aguarde..."

if ./yt-dlp --update-to nightly
then
echo "Atualizado com sucesso."
else
echo "Não foi possível atualizar."
fi
sleep 5
var_looping=1
until [ "$var_looping" -eq 0 ]
do
clear
echo "########################################################"
echo "#        Yt-dpl Video/Playlist donwload to mp3         # "
echo "#                                                      #"
echo "# Site: https://github.com/yt-dlp/yt-dlp               #"
echo "# Update Command: yt-dlp --update-to nightly or stable #"
echo "########################################################"
echo ""
echo "Download de Vídeo ou de Playlist?"
echo "1 - Download de Vídeo"
echo "2 - Download de Playlist"
echo "3 - Sair"
echo -n "Opção: "
read -r var_resposta
	if [ "$var_resposta" -gt 3 ]
	then
		var_looping=1
	else
		if ! [[ "$var_resposta" =~ ^[0-9]+$ ]]
		then
			var_looping=1
		else
			var_looping=0
		fi
	fi
done

if [ "$var_resposta" == 3 ]
then
exit
fi

if [ "$var_resposta" == 1 ]
then
echo -n "Digite o link do Vídeo: "
else
echo -n "Digite o link da Playlist:"
fi

read -r var_link
case "$var_resposta" in
	1) ./yt-dlp --ignore-errors --format bestaudio --extract-audio --audio-format mp3 --audio-quality 160K --output "%(title)s.%(ext)s" "$var_link";;
	2) ./yt-dlp --ignore-errors --format bestaudio --extract-audio --audio-format mp3 --audio-quality 160K --output "%(title)s.%(ext)s" --yes-playlist "$var_link";;
esac
exit 0

