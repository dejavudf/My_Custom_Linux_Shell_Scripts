#!/bin/bash
# GetSubtitle script by dejavudf
# version 1.0 - built 20241121
# debian/ubuntu/mint

FUNC_CHECK_INSTALL() {
clear
echo "Checking subliminal installation status. Please, wait..."
if subliminal --help 2>&1 1>&2 >/dev/null
then
	echo "Subliminal is installed."
	FUNC_MAIN_MENU
else
	echo "Sublininal is not installed. Please install subliminal with command: sudo apt-get install subliminal"
	exit 1
fi
}

FUNC_MAIN_MENU() {
sleep 2
VAR_LOOPING=1
until [ "$VAR_LOOPING" -eq 0 ]
do
clear
echo "##########################################################"
echo "# Subtitle Download Script via subliminal by dejavudf    # "
echo "# Version: 1.0                                           #"
echo "# My site: https://github.com/dejavudf                   #"
echo "# Subliminal site: https://github.com/Diaoul/subliminal/ #"
echo "##########################################################"
echo ""
echo "Select Subtitle Language:"
echo "1 - English from any country"
echo "2 - English from USA only"
echo "3 - English from UK only"
echo "4 - Portuguese from Portugal only"
echo "5 - Portuguese from Brazil only"
echo "6 - Spanish from any country"
echo "7 - Quit"
echo -n "Choice: "
read -r VAR_CHOICE
	if [ "$VAR_CHOICE" -gt 7 ]
	then
		VAR_LOOPING=1
	else
		if ! [[ "$VAR_CHOICE" =~ ^[0-9]+$ ]]
		then
			VAR_LOOPING=1
		else
			VAR_LOOPING=0
		fi
	fi
done
if [ "$VAR_CHOICE" == 7 ]
then
	exit 0
else
	if [ "$VAR_CHOICE" == 1 ]
	then
		VAR_LANG=en
	elif [ "$VAR_CHOICE" == 2 ]
	then
		VAR_LANG=en-US
	elif [ "$VAR_CHOICE" == 3 ]
	then
		VAR_LANG=en-GB
	elif [ "$VAR_CHOICE" == 4 ]
	then
		VAR_LANG=pt
	elif [ "$VAR_CHOICE" == 5 ]
	then
		VAR_LANG=pt-BR
	elif [ "$VAR_CHOICE" == 6 ]
	then
		VAR_LANG=es
	fi
	FUNC_DOWNLOAD
fi
}

FUNC_DOWNLOAD() {
VAR_RUN="$RANDOM"
find ./ -type f | grep -i ".*" | while read -r VAR_FILE
do
	VAR_DATE=$(date '+%Y_%m_%d')
	clear
	echo "Starting subtible download. Please. wait."
	echo "Target Video: $VAR_FILE"
	subliminal --opensubtitles 'test@gmail.com' 'testpassword' download -l "$VAR_LANG" "$VAR_FILE" | tee -a ./"$VAR_DATE"_"$VAR_RUN"_subtitlelog.txt
done
FUNC_MAIN_MENU
}

FUNC_CHECK_INSTALL
