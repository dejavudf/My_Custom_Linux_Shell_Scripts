#!/bin/bash
# Recovery files from usb pendrive using testdisk/photorec software
# by dejavudf
# version 20241105
# debian/ubuntu/mint

#variables
VAR_DISK=""
VAR_DISK_VALIDATION=1

VAR_ROOT="$(whoami)"
if [ ! "$VAR_ROOT" == "root" ]
then
	echo "Run this scripts as root or via sudo."
        exit 1
fi

FUNC_BACKUP() {
./testdisk_static "$VAR_DISK"
}

#script begin - check software
clear
if ./testdisk_static --help > /dev/null 2>1&
then
	until [ "$VAR_DISK_VALIDATION" == "0" ]
	do
		clear
		echo "##################################"
		echo "# Recovery Pendrive Files Script #"
		echo "# by dejavudf - v1.0             #"
		echo "##################################"
		echo "External USB Device List:"
		echo "Disk (/dev/)	Mount Point (/media/)"
		VAR_DISK_LIST="$(df -h | grep -i /dev/sd | awk '{print $1,$6}' | grep -i /media/ )"
		if [ -n "$VAR_DISK_LIST" ]
		then
			echo "$VAR_DISK_LIST"
			echo -n "Choose mount point (/media/): "
			read -r VAR_CHOICE
			if echo "$VAR_DISK_LIST" | grep -i "$VAR_CHOICE" > /dev/null 2>&1
			then
				VAR_DISK=$(echo "$VAR_DISK_LIST" | grep -i "$VAR_CHOICE" | awk '{print $1}')
				VAR_VOLUME=$(echo "$VAR_DISK_LIST" | grep -i "$VAR_CHOICE" | awk '{print $2}')
				if ! umount "$VAR_VOLUME"
				then
					echo "Please, umount disk before proceed."
					sleep 2
				else
        				echo "Starting testdisk. Please, wait."
					sleep 2
					VAR_DISK_VALIDATION=0
        				FUNC_BACKUP
				fi
			else
				echo "Disk (/dev) $VAR_DISK do not exist."
				sleep 2
				VAR_DISK_VALIDATION=1
			fi
		else
			echo "USB device not connected."
			exit 1
		fi
	done
else
	"Testdisk not installed on folder $(pwd). Bye!"
	exit 1
fi
exit 1