#!/bin/bash
# Myping script by Alexsandro Farias (dejavudf@gmail.com)
# version 1.2 - built 20241007
# Ubuntu/Debian

#var declare
var_dt=$(date '+Date_%d_%m_%Y_Time_%H_%M_%S')
var_destination=""
var_destination_validation=0
var_source=""
var_source_validation=0
var_count=""
var_count_validation=0
var_size=""
var_size_validation=0
var_save="n"
var_save_validation=0
var_dfbit="n"
var_dfbit_validation=0
var_background="n"
var_background_validation=0

#Destination IP Menu - Get and Validate
until [ $var_destination_validation -eq 1 ]
do
	clear;
	echo "### Myping Tool By Dejavudf ###";
	echo "<CTRL + C> to quit";
	echo "";
	echo -n "Destination IP: ";
	read var_destination;
	if [[ $var_destination =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]
	then
		if [ $(echo "$var_destination" | cut -d. -f1) -gt 223 ]
        	then
                	var_destination_validation=0;
        	elif [ $(echo "$var_destination" | cut -d. -f2) -gt 255 ]
        	then
                	var_destination_validation=0;
        	elif [ $(echo "$var_destination" | cut -d. -f3) -gt 255 ]
        	then
                	var_destination_validation=0;
        	elif [ $(echo "$var_destination" | cut -d. -f4) -gt 255 ]
        	then
                	var_destination_validation=0;
        	else
                	var_destination_validation=1;
        	fi
	else
  		var_destionation_validation=0;
	fi
done

#Source IP Menu - Get and Validate
until [ $var_source_validation -eq 1 ]
do
        clear;
        echo "### Myping Tool By Dejavudf ###";
        echo "<CTRL + C> to quit";
	echo "";
	echo "Destination IP: $var_destination";
	echo -n "Source IP: ";
        read var_source;
	if [[ $var_source =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]
        then
                if [ $(echo "$var_source" | cut -d. -f1) -gt 223 ]
                then
                       	var_source_validation=0;
                elif [ $(echo "$var_source" | cut -d. -f2) -gt 255 ]
                then
                       	var_source_validation=0;
               	elif [ $(echo "$var_source" | cut -d. -f3) -gt 255 ]
               	then
                       	var_source_validation=0;
               	elif [ $(echo "$var_source" | cut -d. -f4) -gt 255 ]
               	then
                       	var_source_validation=0;
               	else
                       	ip add show | grep -i "$var_source/";
			if [ $? -eq 0 ]
			then
				var_source_validation=1;
			else
				var_source_validation=0;
				echo "IP address not valid. Try again";
				sleep 2;
			fi
		fi
       	else
    	           	var_source_validation=0;
       	fi
done

#Count Menu - Get and Validate
until [ $var_count_validation -eq 1 ]
do
        clear;
        echo "### Myping Tool By Dejavudf ###";
        echo "<CTRL + C> to quit";
	echo "";
	echo "Destination IP: $var_destination";
        echo "Source IP: $var_source";
	echo -n "Count: ";
        read -n 5 var_count;
        if [[ $var_count =~ ^[0-9]+$ ]]
        then
		if [ $var_count -gt 65535 ] || [ $var_count -eq 0 ]
		then
			var_count_validation=0;
		else
			var_count_validation=1;
		fi
        else
                var_count_validation=0;
        fi
done

#Size Menu - Get and Validate
until [ $var_size_validation -eq 1 ]
do
        clear;
        echo "### Myping Tool By Dejavudf ###";
        echo "<CTRL + C> to quit";
        echo "";
        echo "Destination IP: $var_destination";
        echo "Source IP: $var_source";
        echo "Count: $var_count";
        echo -n "Size: ";
	read -n 5 var_size;
        if [[ $var_size =~ ^[0-9]+$ ]]
        then
                if [ $var_size -gt 65535 ]
                then
                        var_size_validation=0;
                else
                        var_size_validation=1;
                fi
        else
                var_size_validation=0;
        fi
done

#Defrag Bit - Get and Validate
until [ $var_dfbit_validation -eq 1 ]
do
        clear;
        echo "### Myping Tool By Dejavudf ###";
        echo "<CTRL + C> to quit";
        echo "";
        echo "Destination IP: $var_destination";
        echo "Source IP: $var_source";
        echo "Count: $var_count";
        echo "Size: $var_size";
        echo -n "Do not fragment (y/n)? ";
	read var_dfbit;
        if [ "$var_dfbit" == "y" ]
        then
        	var_dfbit_validation=1;
        elif [ "$var_dfbit" == "n" ]
	then
                var_dfbit_validation=1;
        else
                var_dfbit_validation=0;
	fi
done


#Save File Menu - Get and Validate
until [ $var_save_validation -eq 1 ]
do
        clear;
        echo "### Myping Tool By Dejavudf ###";
        echo "<CTRL + C> to quit";
        echo "";
        echo "Destination IP: $var_destination";
        echo "Source IP: $var_source";
        echo "Count: $var_count";
        echo "Size: $var_size";
        echo "Do not fragment: $var_dfbit";
	echo -n "Save to file (y/n)? ";
        read var_save;
        if [ "$var_save" == "y" ]
        then
                var_save_validation=1;
        elif [ "$var_save" == "n" ]
        then
                var_save_validation=1;
        else
                var_save_validation=0;
        fi
done

#Background Menu - Get and Validate
if [ "$var_save" == "y" ]
then
	until [ $var_background_validation -eq 1 ]
	do
        	clear;
        	echo "### Myping Tool By Dejavudf ###";
        	echo "<CTRL + C> to quit";
        	echo "";
        	echo "Destination IP: $var_destination";
        	echo "Source IP: $var_source";
        	echo "Count: $var_count";
        	echo "Size: $var_size";
        	echo "Do not fragment: $var_dfbit";
        	echo "Save to file: $var_save ";
		echo "File to be saved: $var_dt""_from_""$var_source""_to_""$var_destination"".txt"; 
		echo -n "Run in Background? ";
        	read var_background;
        	if [ "$var_background" == "y" ]
        	then
                	var_background_validation=1;
       		elif [ "$var_background" == "n" ]
        	then
                	var_background_validation=1;
			echo "Starting ping..." && sleep 2;
        	else
                	var_background_validation=0;
        	fi
	done
else
	echo "Starting ping..." && sleep 2;
fi

#Ping start
if [  "$var_save" == "y" ] && [ "$var_dfbit" == "y" ] && [ "$var_background" == "n" ]
then
	ping -I $var_source -c $var_count -s $var_size -M do $var_destination -B -v | while read var_pong; do echo "$(date '+%d/%m/%Y - %H:%M:%S') -> $var_pong"; done | tee ./"$var_dt""_from_""$var_source""_to_""$var_destination"".txt"
elif [  "$var_save" == "y" ] && [ "$var_dfbit" == "n" ] && [ "$var_background" == "n" ]
then
	ping -I $var_source -c $var_count -s $var_size $var_destination -B -v | while read var_pong; do echo "$(date '+%d/%m/%Y - %H:%M:%S') -> $var_pong"; done | tee ./"$var_dt""_from_""$var_source""_to_""$var_destination"".txt"
elif [  "$var_save" == "n" ] && [ "$var_dfbit" == "y" ] && [ "$var_background" == "n" ]
then
	ping -I $var_source -c $var_count -s $var_size -M do $var_destination -B -v | while read var_pong; do echo "$(date '+%d/%m/%Y - %H:%M:%S') -> $var_pong"; done

elif [  "$var_save" == "y" ] && [ "$var_background" == "y" ] && [ "$var_dfbit" == "y" ]
then
        nohup ping -I $var_source -c $var_count -s $var_size -M do $var_destination -B -v | while read var_pong; do echo "$(date '+%d/%m/%Y - %H:%M:%S') -> $var_pong"; done > ./"$var_dt""_from_""$var_source""_to_""$var_destination"".txt" &
elif [  "$var_save" == "y" ] && [ "$var_background" == "y" ] && [ "$var_dfbit" == "n" ]
then
        nohup ping -I $var_source -c $var_count -s $var_size -M do $var_destination -B -v | while read var_pong; do echo "$(date '+%d/%m/%Y - %H:%M:%S') -> $var_pong"; done > ./"$var_dt""_from_""$var_source""_to_""$var_destination"".txt" &
else
	ping -I $var_source -c $var_count -s $var_size $var_destination -B -v | while read var_pong; do echo "$(date '+%d/%m/%Y - %H:%M:%S') -> $var_pong"; done
fi

#final check and print status
if [ "$var_background" == "y" ]
then
	echo "Ping running in background";
	echo "Jobs (PID) info:";
	echo "$(jobs -l)";
	echo "File been saved: $var_dt""_from_""$var_source""_to_""$var_destination"".txt";
	echo "### Job added in $(date '+%d/%m/%Y - %H:%M:%S') ###" >> jobs.txt;
        echo "$(jobs -l)" >> ./jobs.txt;
	echo "File being saved: $var_dt""_from_""$var_source""_to_""$var_destination"".txt" >> ./jobs.txt;
elif [ "$var_save" == "y" ] && [ "$var_background" == "n" ]
then
	echo "File saved: $var_dt""_from_""$var_source""_to_""$var_destination"".txt";
	echo "bye.";
else
	echo "bye.";
fi
exit

