#!/bin/bash
# Capture Packet script by Alexsandro Farias (dejavudf@gmail.com)
# version 1.0 - built 20241009
# Ubuntu/Debian

#var declare
var_dt=$(date '+Date_%d_%m_%Y_Time_%H_%M_%S')
var_interface=""
var_interface_validation=0
var_target_net=""
var_target_net_validation=0
var_target_subnet=""
var_target_subnet=0
var_save="n"
var_save_validation=0
var_size=""
var_size_validation=0
var_time=""
var_time_validation=0
var_protocol=""
var_protocol_validation=0
var_port=""
var_port_validation=0
var_background="n"
var_background_validation=0

#Source Interface Menu - Get and Validate
until [ $var_interface_validation -eq 1 ]
do
	clear;
	echo "### Capture Packet Tool By Dejavudf ###";
	echo "<CTRL + C> to quit";
	echo "";
	echo "Type ethX or any";
	echo -n "Source Interface: ";
	read var_interface;
        tcpdump -D | grep -i ".$var_interface ";
	if [ $? -eq 0 ]
	then
		var_interface_validation=1;
	else
		var_interface_validation=0;
		echo "Source Interface not found. Try again";
                sleep 2
	fi
done

#Target Network Menu - Get and Validate
until [ $var_target_net_validation -eq 1 ]
do
        clear;
        echo "### Capture Packet Tool By Dejavudf ###";
        echo "<CTRL + C> to quit";
	echo "";
	echo "Source Interface: $var_interface";
	echo -n "Target IP/Network (without mask or subnet): ";
        read var_target_net;
	if [[ $var_target_net =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]
        then
                if [ $(echo "$var_target_net" | cut -d. -f1) -gt 255 ]
                then
                       	var_target_net_validation=0;
                elif [ $(echo "$var_target_net" | cut -d. -f2) -gt 255 ]
                then
                       	var_target_net_validation=0;
               	elif [ $(echo "$var_target_net" | cut -d. -f3) -gt 255 ]
               	then
                       	var_target_net_validation=0;
               	elif [ $(echo "$var_target_net" | cut -d. -f4) -gt 255 ]
               	then
                       	var_target_net_validation=0;
               	else
			var_target_net_validation=1
		fi
       	else
    	           	var_target_net_validation=0;
       	fi
done

#Target Subnet Menu - Get and Validate
until [ $var_target_subnet_validation -eq 1 ]
do
        clear;
        echo "### Capture Packet Tool By Dejavudf ###";
        echo "<CTRL + C> to quit";
	echo "";
	echo "Source Interface: $var_interface";
        echo "Target IP/Network: $var_target_net";
	echo -n "Subnet (CIDR Format): /";
        read -n 5 var_target_subnet;
        if [[ $var_target_subnet =~ ^[0-9]+$ ]]
        then
		if [ $var_target_subnet -gt 32 ] || [ $var_count -eq 0 ]
		then
			var_target_subnet_validation=0;
		else
			var_target_subnet_validation=1;
		fi
        else
                var_target_subnet_validation=0;
        fi
done

#Save File Menu - Get and Validate
until [ $var_save_validation -eq 1 ]
do
        clear;
        echo "### Capture Packet Tool By Dejavudf ###";
        echo "<CTRL + C> to quit";
        echo "";
        echo "Source Interface: $var_interface";
        echo "Target IP/Network: $var_target_net/$var_target_subnet";
        echo -n "Save Capture to file (y/n)?: ";
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

#File Size Menu - Get and Validate
until [ $var_size_validation -eq 1 ]
do
        clear;
        echo "### Capture Packet Tool By Dejavudf ###";
        echo "<CTRL + C> to quit";
        echo "";
        echo "Source Interface: $var_interface";
        echo "Target IP/Network: $var_target_net/$var_target_subnet";
        echo "Save Capture to file?: $var_save"
	echo -n "Max Capture File Size (Mbytes: 1 to 1000): ";
	read -n 5 var_size;
        if [[ $var_size =~ ^[0-9]+$ ]]
        then
                if [ $var_size -gt 1000 ] || [ $var_size -eq 0 ]
                then
                        var_size_validation=0;
                else
                        var_size_validation=1;
                fi
        else
                var_size_validation=0;
        fi
done

#Time Menu - Get and Validate
until [ $var_time_validation -eq 1 ]
do
        clear;
        echo "### Capture Packet Tool By Dejavudf ###";
        echo "<CTRL + C> to quit";
        echo "";
        echo "Source Interface: $var_interface";
        echo "Target IP/Network: $var_target_net/$var_target_subnet";
        echo "Save Capture to File? $var_save";
        echo "File Max Size: $var_size Mbytes";
        echo -n "Capture Time (minutes: 1 to 1000): ";
	read var_time;
        if [[ $var_time =~ ^[0-9]+$ ]]
        then
                if [ $var_time -gt 1000 ] || [ $var_time -eq 0 ]
                then
                        var_time_validation=0;
                else
                        var_time_validation=1;
                fi
        else
                var_time_validation=0;
        fi
done

#Protocol Menu - Get and Validate
until [ $var_protocol_validation -eq 1 ]
do
        clear;
        echo "### Capture Packet Tool By Dejavudf ###";
        echo "<CTRL + C> to quit";
        echo "";
        echo "Source Interface: $var_interface";
        echo "Target IP/Network: $var_target_net/$var_target_subnet";
        echo "Save Capture to File? $var_save";
        echo "File Max Size: $var_size Mbytes";
        echo "Capture Time: $var_time minutes";
	echo -n "Protocol (tcp, udp, icmp or any): "
        read var_protocol;
	case $var_protocol in
        	tcp)
			var_protocol=tcp
			var_protocol_validation=1;;
        	udp)
			var_protocol=udp
			var_protocol_validation=1;;
		icmp)
			var_protocol=icmp
			var_protocol_validation=1;;
		any)
			var_protocol=any
			var_protocol_validation=1;;
	esac
done

#Port Menu - Get and Validate
until [ $var_port_validation -eq 1 ]
do
        clear;
        echo "### Capture Packet Tool By Dejavudf ###";
        echo "<CTRL + C> to quit";
        echo "";
        echo "Source Interface: $var_interface";
        echo "Target IP/Network: $var_target_net/$var_target_subnet";
        echo "Save Capture to File? $var_save";
        echo "File Max Size: $var_size Mbytes";
        echo "Capture Time: $var_time minutes";
        echo "Protocol: $var_protocol"
        echo -n "UDP/TCP Port (1 to 65535 or any):"
	read var_port;
                if [[ $var_port =~ ^[0-9]+$ ]]
        then
                if [ $var_port -gt 65535 ] || [ $var_port -eq 0 ]
                then
                        var_port_validation=0;
                else
                        var_port_validation=1;
                fi
        else
		if [ "$var_port" == "any" ]
		then
			var_port_validation=1
		else
			var_port_validation=0
		fi
        fi
done

#Background Menu - Get and Validate
if [ "$var_save" == "y" ]
then
	until [ $var_background_validation -eq 1 ]
	do
        	clear;
		echo "### Capture Packet Tool By Dejavudf ###";
		echo "<CTRL + C> to quit";
		echo "";
		echo "Source Interface: $var_interface";
		echo "Target IP/Network: $var_target_net/$var_target_subnet";
		echo "Save Capture to File? $var_save";
		echo "File Max Size: $var_size Mbytes";
		echo "Capture Time: $var_time minutes";
		echo "Protocol: $var_protocol"
		echo "UDP/TCP Port: $var_port"
		echo -n "Run in Background? ";
        	read var_background;
        	if [ "$var_background" == "y" ]
        	then
                	var_background_validation=1;
       		elif [ "$var_background" == "n" ]
        	then
                	var_background_validation=1;
			echo "Starting capture..." && sleep 2;
        	else
                	var_background_validation=0;
        	fi
	done
else
	echo "Starting capture..." && sleep 2;
fi

#Capture start
if [  "$var_save" == "y" ] && [ "$var_background" == "n" ]
then
	ping -I $var_source -c $var_count -s $var_size -M do $var_destination -B -v | while read var_pong; do echo "$(date '+%d/%m/%Y - %H:%M:%S') -> $var_pong"; done | tee ./"$var_dt""_from_""$var_source""_to_""$var_destination"".txt"
elif [  "$var_save" == "y" ] && [ "$var_background" == "y" ]
then
	ping -I $var_source -c $var_count -s $var_size $var_destination -B -v | while read var_pong; do echo "$(date '+%d/%m/%Y - %H:%M:%S') -> $var_pong"; done | tee ./"$var_dt""_from_""$var_source""_to_""$var_destination"".txt"
elif [  "$var_save" == "n" ] && [ "$var_background" == "n" ]
then
	ping -I $var_source -c $var_count -s $var_size -M do $var_destination -B -v | while read var_pong; do echo "$(date '+%d/%m/%Y - %H:%M:%S') -> $var_pong"; done
        nohup ping -I $var_source -c $var_count -s $var_size -M do $var_destination -B -v | while read var_pong; do echo "$(date '+%d/%m/%Y - %H:%M:%S') -> $var_pong"; done > ./"$var_dt""_from_""$var_source""_to_""$var_destination"".txt" &
else
	ping -I $var_source -c $var_count -s $var_size $var_destination -B -v | while read var_pong; do echo "$(date '+%d/%m/%Y - %H:%M:%S') -> $var_pong"; done
fi

#final check and print status
if [ "$var_background" == "y" ]
then
	echo "Capture running in background";
	echo "Jobs (PID) info:";
	echo "$(jobs -l)";
	echo "File Name: $var_dt""_Int_""$var_interface""_Target_""$var_target_net""_""CIDR""$var_target_subnet""_Protocol_""$var_protocol""_Port_""$var_port.txt";
	echo "### Job added in $(date '+%d/%m/%Y - %H:%M:%S') ###" >> jobs.txt;
        echo "$(jobs -l)" >> ./jobs.txt;
	echo "File Name: $var_dt""_Int_""$var_interface""_Target_""$var_target_net""_""CIDR""$var_target_subnet""_Protocol_""$var_protocol""_Port_""$var_port.txt" >> ./jobs.txt;
elif [ "$var_save" == "y" ] && [ "$var_background" == "n" ]
then
	echo "File Name: $var_dt""_Int_""$var_interface""_Target_""$var_target_net""_""CIDR""$var_target_subnet""_Protocol_""$var_protocol""_Port_""$var_port.txt";
	echo "bye.";
else
	echo "bye.";
fi
exit

