#!/bin/bash
# myconvertervideo by dejavudf
# version 1.0 - built 20241128
# Debian/Ubuntu/MintUbuntu

#check ffmpeg installation status
FUNC_CHECK_INSTALL() {
clear
echo "Checking ffmpeg installation status. Please, wait..."
if ffmpeg --help > /dev/null
then
	echo "ffmpeg is installed."
	sleep 1
else
	echo "ffmpeg is not installed. Please install subliminal with command: sudo apt-get install ffmpeg"
	exit 1
fi
}

#variables
FUNC_VAR_CLEAR() {
VAR_SOURCE_FILE=""
VAR_SOURCE_FILE_VALIDATION=1
VAR_SOURCE_VIDEO=""
VAR_SOURCE_AUDIO=""
VAR_SOURCE_RESOLUTION=""
VAR_SOURCE_FORMAT=""
VAR_DESTINATION_FILE=""
VAR_DESTINATION_FILE_VALIDATION=1
VAR_DESTINATION_VIDEO=""
VAR_DESTINATION_AUDIO=""
VAR_DESTINATION_VIDEO_VALIDATION=1
VAR_DESTINATION_AUDIO_VALIDATION=1
VAR_DESTINATION_RESOLUTION=""
VAR_DESTINATION_RESOLUTION_VALIDATION=1
VAR_DESTINATION_FORMAT=""
VAR_DESTINATION_FORMAT_VALIDATION=1
FUNC_SOURCE_FILE
}

#func main screen
FUNC_MAIN_SCREEN() {
clear
echo "[--------------------------------]"
echo "| MyVideoConverter               |"
echo "| by Dejavudf                    |"
echo "[--------------------------------|"
echo "| Codecs List: ffmpeg -codecs    |"
echo "| Formats List: ffmpeg -formats  | "
echo "[--------------------------------]"
echo "| CTRL + C to Quit               |"
echo "[--------------------------------]"
echo "| Source File Name:              -> $VAR_SOURCE_FILE"
echo "| Destination File Name:         -> $VAR_DESTINATION_FILE"
echo "| Source Video CODEC:            -> $VAR_SOURCE_VIDEO"
echo "| Source Video/File Format:      -> $VAR_SOURCE_FORMAT"
echo "| Source Video Resolution        -> $VAR_SOURCE_RESOLUTION"
echo "| Souce Audio CODEC:             -> $VAR_SOURCE_AUDIO"
echo "| Destination Video CODEC:       -> $VAR_DESTINATION_VIDEO"
echo "| Destination Video Resolution:  -> $VAR_DESTINATION_RESOLUTION"
echo "| Destination Video/File Format: -> $VAR_DESTINATION_FORMAT"
echo "| Destination Audio CODEC:       -> $VAR_DESTINATION_AUDIO"
echo "[--------------------------------]"
}

#func get source file
FUNC_SOURCE_FILE() {
while [ "$VAR_SOURCE_FILE_VALIDATION" == 1 ]
do
	FUNC_MAIN_SCREEN
	echo -n "  Source File Name: "
	read -r VAR_SOURCE_FILE
	if [ -r "$VAR_SOURCE_FILE" ]
	then
		echo "Validanting file format and codecs. Please, wait..."
		ffmpeg -i "$VAR_SOURCE_FILE" 2> /tmp/ffmpeg.tmp
		VAR_SOURCE_VIDEO=$(cat < /tmp/ffmpeg.tmp | grep Video | awk -F"," '{print $1}' | awk '{print $4}')
		VAR_SOURCE_RESOLUTION=$(cat < /tmp/ffmpeg.tmp | grep Video | awk -F"," '{print $4}' | awk '{print $1}')
		VAR_SOURCE_AUDIO=$(cat < /tmp/ffmpeg.tmp | grep Audio | awk -F"," '{print $1}' | awk '{print $4}')
		VAR_SOURCE_FORMAT=$(cat < /tmp/ffmpeg.tmp | grep Input | awk -F"," '{print $2}')
		VAR_SOURCE_FORMAT=$(echo "${VAR_SOURCE_FORMAT//[[:blank:]]/}")
		VAR_SOURCE_FILE_VALIDATION=0
	else
		echo "Error: wrong file name ou file name with invalid characteres. Please, try again."
		sleep 3
		VAR_SOURCE_FILE_VALIDATION=1
		VAR_SOURCE_FILE=""
	fi
done
FUNC_DESTINATION_VIDEO
}

#func get destination video codec
FUNC_DESTINATION_VIDEO() {
while [ "$VAR_DESTINATION_VIDEO_VALIDATION" == 1 ]
do
        ffmpeg -codecs > /tmp/codecs.tmp
	FUNC_MAIN_SCREEN
      	echo -n "  Destination Video CODEC (type none to keep source CODEC): "
        read -r VAR_DESTINATION_VIDEO
	if [ "$VAR_DESTINATION_VIDEO" == "none" ]
	then
		VAR_DESTINATION_VIDEO="copy"
		VAR_DESTINATION_VIDEO_VALIDATION=0
	else
		echo "Validating destination Video Codec. Please, wait..."
		if cat < /tmp/codecs.tmp | grep "DEV" | grep " $VAR_DESTINATION_VIDEO "
		then
			VAR_DESTINATION_VIDEO_VALIDATION=0
		else
			VAR_DESTINATION_VIDEO=""
			VAR_DESTINATION_VIDEO_VALIDATION=1
		fi
	fi
done
FUNC_DESTINATION_AUDIO
}

#func get destination audio codec
FUNC_DESTINATION_AUDIO() {
while [ "$VAR_DESTINATION_AUDIO_VALIDATION" == 1 ]
do
        FUNC_MAIN_SCREEN
        echo -n "  Destination Audio CODEC (type none to keep source CODEC): "
        read -r VAR_DESTINATION_AUDIO
	if [ "$VAR_DESTINATION_AUDIO" == "none" ]
	then
		VAR_DESTINATION_AUDIO="copy"
		VAR_DESTINATION_AUDIO_VALIDATION=0
	else
		echo "Validating destination Audio Codec. Please, wait..."
		if cat < /tmp/codecs.tmp | grep "DEA" | grep " $VAR_DESTINATION_AUDIO "
        	then
                	VAR_DESTINATION_AUDIO_VALIDATION=0
        	else
                	VAR_DESTINATION_AUDIO_VALIDATION=1
			VAR_DESTINATION_AUDIO=""
        	fi
	fi
done
FUNC_DESTINATION_RESOLUTION
}

#func get destination video resolution
FUNC_DESTINATION_RESOLUTION() {
while [ "$VAR_DESTINATION_RESOLUTION_VALIDATION" == 1 ]
do
	FUNC_MAIN_SCREEN
	echo "  1 - HD 1280x720"
	echo "  2 - FHD 1920x1080"
	echo "  3 - none (keep video source resolution)"
	echo -n "  Choice: "
	read -r -n 1 VAR_DESTINATION_RESOLUTION
	if [ "$VAR_DESTINATION_RESOLUTION" == "3" ]
	then
		VAR_DESTINATION_RESOLUTION_SCALE=$(echo "$VAR_SOURCE_RESOLUTION" | sed 's/x/:/g')
		VAR_DESTINATION_RESOLUTION="$VAR_SOURCE_RESOLUTION"
		VAR_DESTINATION_RESOLUTION="none"
		VAR_DESTINATION_RESOLUTION_VALIDATION=0
	elif [ "$VAR_DESTINATION_RESOLUTION" == "2" ]
	then
		VAR_DESTINATION_RESOLUTION_SCALE="1920:1080"
		VAR_DESTINATION_RESOLUTION_VALIDATION=0
		VAR_DESTINATION_RESOLUTION="1920x1080"
	elif [ "$VAR_DESTINATION_RESOLUTION" == "1" ]
	then
		VAR_DESTINATION_RESOLUTION_SCALE="1280:720"
                VAR_DESTINATION_RESOLUTION_VALIDATION=0
		VAR_DESTINATION_RESOLUTION="1280x720"
	else
		VAR_DESTINATION_RESOLUTION=""
		VAR_DESTINATION_RESOLUTION_VALIDATION=1
	fi
done
FUNC_DESTINATION_FILE
}

#func get destination file name
FUNC_DESTINATION_FILE() {
while [ "$VAR_DESTINATION_FILE_VALIDATION" == 1 ]
do
	FUNC_MAIN_SCREEN
	echo -n "  Destination File name: "
	read -r VAR_DESTINATION_FILE
	echo "Validating destination file name. Please, wait..."
	VAR_DESTINATION_FILE_SIZE=$(echo "${#VAR_DESTINATION_FILE}")
	if [[ "$VAR_DESTINATION_FILE" =~ ^[0-9a-zA-Z_-]+$ ]] && [ "$VAR_DESTINATION_FILE_SIZE" -lt 255 ]
	then
		VAR_DESTINATION_FILE_VALIDATION=0
	else
		VAR_DESTINATION_FILE=""
		VAR_DESTINATION_FILE_VALIDATION=1
	fi
done
FUNC_DESTINATION_FORMAT
}

#func get destination format
FUNC_DESTINATION_FORMAT() {
while [ "$VAR_DESTINATION_FORMAT_VALIDATION" == 1 ]
do
        ffmpeg -formats > /tmp/formats.tmp
	FUNC_MAIN_SCREEN
        echo -n "  Destination Video/File Format: "
        read -r VAR_DESTINATION_FORMAT
	echo "Validating destination Video/file format. Please, wait..."
        if cat < /tmp/formats.tmp | grep "DE" | grep " $VAR_DESTINATION_FORMAT "
        then
		VAR_DESTINATION_FILE_NAME="$VAR_DESTINATION_FILE"".""$VAR_DESTINATION_FORMAT"
                VAR_DESTINATION_FORMAT_VALIDATION=0
        else
                VAR_DESTINATION_FORMAT=""
                VAR_DESTINATION_FORMAT_VALIDATION=1
        fi
done
FUNC_VIDEO_CONVERT
}

#func video convert
FUNC_VIDEO_CONVERT() {
FUNC_MAIN_SCREEN
echo "Starting Video/Audio convertion. Please, wait..."
if [ "$VAR_DESTINATION_VIDEO" == "copy" ]
then
	if ffmpeg -i "$VAR_SOURCE_FILE" -vcodec "$VAR_DESTINATION_VIDEO" -acodec "$VAR_DESTINATION_AUDIO" "$VAR_DESTINATION_FILE_NAME"
	then
		FUNC_MAIN_SCREEN
        	echo "Video/Audio converted successfuly."
        	echo "File saved: $VAR_DESTINATION_FILE_NAME"
        	sleep 10
        	FUNC_VAR_CLEAR
	else
        	echo "Error: Video/Audio conversion error. Please, change parameters and try again."
		sleep 10
		FUNC_VAR_CLEAR
	fi
else
	if ffmpeg -i "$VAR_SOURCE_FILE" -vcodec "$VAR_DESTINATION_VIDEO" -acodec "$VAR_DESTINATION_AUDIO" -vf scale="$VAR_DESTINATION_RESOLUTION_SCALE" \
	"$VAR_DESTINATION_FILE_NAME"
	then
		FUNC_MAIN_SCREEN
        	echo "Video/Audio converted successfuly."
        	echo "File saved: $VAR_DESTINATION_FILE_NAME"
        	sleep 10
        	FUNC_VAR_CLEAR
	else
        	echo "Error: Video/Audio conversion error. Please, change parameters and try again."
		sleep 10
		FUNC_VAR_CLEAR
	fi
fi
}

#script begin
FUNC_CHECK_INSTALL
FUNC_VAR_CLEAR
