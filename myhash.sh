#!/bin/bash
# Myhasg script by Alexsandro Farias (dejavudf@gmail.com)
# version 1.0 - built 20210922
# Ubuntu/Debian

var_looping=1
var_answer=3
var_file_name=""
var_file_name_validation=1
var_sha_choice=1
var_sha_choice_validation=1

until [ $var_looping -eq 0 ]
do
	clear
	echo "########################################################"
	echo "#             My Check files hash MD5/SHA              # "
	echo "#                                                      #"
	echo "# by dejavudf (https://gibhub/com/dejavudf             #"
	echo "########################################################"
	echo ""
	echo "1 - MD5"
	echo "2 - SHA"
	echo "3 - Quit"
	echo -n "Choice: "
	read var_answer
	if [ $var_answer -gt 3 ]
	then
		var_looping=1
	else
		if ! [[ "$var_answer" =~ ^[0-9]+$ ]]
		then
			var_looping=1
		else
			var_looping=0
		fi
	fi
done

if [ $var_answer == 3 ]
then
	exit
elif [ $var_answer == 1 ]
then
	while [ $var_file_name_validation != 0 ]
	do
		clear
        	echo "########################################################"
        	echo "#             My Check files hash MD5/SHA              # "
        	echo "#                                                      #"
        	echo "# by dejavudf (https://gibhub/com/dejavudf             #"
        	echo "########################################################"
        	echo ""
        	echo "Calc hash using MD5."
		echo ""
		echo -n "Type file name or file mask: "
		read var_file_name;
		ls $var_file_name 2>/dev/null
		if [ $? == 0 ]
		then
			echo "Hash:"
			md5sum $var_file_name
			var_file_name_validation=0;
		else
			echo "File(s) not found. Try again"
			var_file_name_validation=1;
			sleep 2
		fi
	done
elif [ $var_answer == 2 ]
then
	while [ $var_file_name_validation != 0 ]
	do
		clear
		echo "########################################################"
		echo "#             My Check files hash MD5/SHA              # "
		echo "#                                                      #"
		echo "# by dejavudf (https://gibhub/com/dejavudf             #"
		echo "########################################################"
		echo ""
		echo "Calc hash using SHA."
		echo -n "Type file name or file mask: "
		read var_file_name
		ls $var_file_name 2>/dev/null
		if [ $? == 0 ]
		then
			var_file_name_validation=0
			while [ $var_sha_choice_validation != 0 ]
			do
				clear
                		echo "########################################################"
                		echo "#             My Check files hash MD5/SHA              # "
                		echo "#                                                      #"
                		echo "# by dejavudf (https://gibhub/com/dejavudf             #"
                		echo "########################################################"
                		echo ""
                		echo "Calc hash using SHA."
                		echo "File name/mask: $var_file_name"
				echo -n "Choose SHA algoritm (1, 224, 256, 384 or 512): "
				read var_sha_choice
				case $var_sha_choice in
					1|224|256|384|512)
						shasum -a $var_sha_choice $var_file_name
						var_sha_choice_validation=0;;
					*)
						var_sha_choice_validation=1;;
				esac
			done
		else
			echo "File(s) not found. Try again."
			sleep 2
			var_file_name_validation=1;
		fi
	done
fi
exit

