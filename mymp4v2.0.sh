#!/bin/bash
# MyMp4 Youtube Download to mp4 script by dejavudf
# version 2.0 - built 01/11/2024
# Ubuntu/Debian/Mint

#variables
var_resposta=""
var_looping=1
var_url="URL incorreta ou inválida. Tente novamente."

#check if ffmpeg is installed
if ! ffmpeg --help
then
	echo "ffmpeg não instalado."	
else

#download yt-dlp
clear
echo "Baixandoyt-dlp. Por favor, aguarde..."
if wget https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp
then
	chmod u+x ./yt-dlp
	echo "Sucesso ao fazer download do yt-dlp."
	rm -f ./yt-dlp.*
else
	echo "Erro ao tentar fazer download do yt-dlp."
fi
sleep 2

#update yt-dlp
clear
echo "Atualizando yt-dlp. Por favor, aguarde..."
if ./yt-dlp --update-to nightly
then
	echo "yt-dlp atualizado com sucesso."
else
	echo "Não foi possível atualizar o yt-dlp."
fi
sleep 2

#func start
func_start() {
read -r var_link
if ! echo "$var_link" | grep -i "https://www.youtube.com/"
then
	echo "$var_url"
	sleep 3
	func_menu
elif ! curl -L -o /dev/null -s -w "%{200}\n" "$var_link"
then
	echo "$var_url"
	sleep 3
	func_menu
else
	case "$var_resposta" in
        	1)
			if ./yt-dlp --ignore-errors -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' -o "%(title)s.%(ext)s" $var_link
			then
				echo "Sucesso!"
				sleep 3
				exit 0
			else
				echo "Erro. Tente novamente."
				sleep 3
				func_menu
			fi;;
		2)
                	if ./yt-dlp --ignore-errors -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' -o "%(title)s.%(ext)s" --yes-playlist $var_link
			then
                                echo "Sucesso!"
                                sleep 3
                                exit 0
                        else
                                echo "Erro. Tente novamente."
                                sleep 3
                                func_menu
                        fi;;
	esac
fi
}

#func menu
func_menu() {
var_looping=1
until [ "$var_looping" -eq "0" ]
do
	clear
	echo "########################################################"
	echo "#        Yt-dpl Video/Playlist donwload to mp4         # "
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
if [ "$var_resposta" == "3" ]
then
	exit
elif [ "$var_resposta" == "1" ]
then
	echo -n "Digite o link do Vídeo: "
	func_start
elif [ "$var_resposta" == "2" ]
then
	echo -n "Digite o link da Playlist:"
	func_start
else
	:
fi
}

#open principal menu
func_menu
fi
