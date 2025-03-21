#!/bin/bash
# mycreatevm script - create virtual machine using virtinstall
# version 2.0 - build 28/10/2024
# by dejavudf

#change colours - theme: Flamengo
export NEWT_COLORS='
	root=,gray
	entry=,gray
	roottext=gray,black
'
#whiptail parameter to var
VAR_BT_E="Enter"
VAR_BT_Q="Quit"
VAR_BT_C="Continue"
VAR_T="Create Virtual Machine - VirtInstall"
VAR_BKT="dejavudf@gmail.com - https//github.com/dejavudf/"
VAR_MB="Invalid Input Value!"
VAR_MB2="You've missed something. Please, fill all fields and try again"

FUNC_MAIN_MENU() {
until [ "$VAR_MAIN_MENU_VALIDATION" == 0 ]
do
        clear
        VAR_MAIN_MENU=$(whiptail --clear --ok-button "Enter" --cancel-button "Quit" --title "$VAR_T" --backtitle "Create VM with Virt-Install" --menu "Main Menu:" \
	0 0 11 "1" "> Name: $VAR_VM_NAME" "2" "> RAM (Mb): $VAR_VM_RAM" "3" "> CPU: x $VAR_CPU" "4" "> Machine Type: $VAR_MACHINE_TYPE" \
	"5" "> OS Type/Variant: $VAR_OS_TYPE" "6" "> Graph: $VAR_GRAPH" "7" "> Boot Disk: $VAR_BOOT $VAR_CDR" "8" "> Disk Size (Gb): $VAR_DISK_SIZE" \
	"9" "> Disk Bus: $VAR_DISK_BUS" "10" "> Nic Type (bridge mode): $VAR_NET_MODEL" "11" "> Create VM" 3>&2 2>&1 1>&3)
        if [ $? == 1 ]
        then
                exit
        elif [ $? == 255 ]
        then
                VAR_MAIN_MENU_VALIDATION=1
                continue
        else
                if [ "$VAR_MAIN_MENU" == 1 ]
                then
                        FUNC_NAME
                elif [ "$VAR_MAIN_MENU" == 2 ]
                then
                        FUNC_RAM
                elif [ "$VAR_MAIN_MENU" == 3 ]
                then
                        FUNC_CPU
                elif [ "$VAR_MAIN_MENU" == 4 ]
                then
                        FUNC_MACHINE
		elif [ "$VAR_MAIN_MENU" == 5 ]
                then
                        FUNC_OS
		elif [ "$VAR_MAIN_MENU" == 6 ]
                then
                        FUNC_GRAPH
		elif [ "$VAR_MAIN_MENU" == 7 ]
                then
                        FUNC_BOOT
		elif [ "$VAR_MAIN_MENU" == 8 ]
                then
                        FUNC_DISK
		elif [ "$VAR_MAIN_MENU" == 9 ]
                then
                        FUNC_BUS
		elif [ "$VAR_MAIN_MENU" == 10 ]
                then
                        FUNC_NET
		elif [ "$VAR_MAIN_MENU" == 11 ]
                then
                        FUNC_CREATE
                else
                        VAR_CPU_VALIDATION=1
                fi
        fi
done
}

#function for invalid input text (number, string, etcetera)
FUNC_INVALID_INPUT() {
	clear
	whiptail --clear --title "$VAR_T" --backtitle "$VAR_BKT" --msgbox "$VAR_MB" --ok-button "$VAR_BT_C" 0 0
}

#function for invalid input text (number, string, etcetera)
FUNC_FIELD_EMPTY() {
        clear
        whiptail --clear --title "$VAR_T" --backtitle "$VAR_BKT" --msgbox "$VAR_MB2" --ok-button "$VAR_BT_C" 0 0
}

#script begin
#check run as root (sudo)
VAR_CHECK_ROOT=$(whoami)
if [ "$VAR_CHECK_ROOT" != "root" ]
then
	whiptail --clear --title "$VAR_T" --backtitle "$VAR_BKT" --msgbox "You need to run this script as root or via sudo!" --ok-button "Quit" 0 0
	exit 1
else
	:
fi

#Show Intro Info
whiptail --clear --title "$VAR_T" --backtitle "$VAR_BKT" --msgbox "Wellcome to MyCreateVm VirtInstall Script v1.0" --ok-button "$VAR_BT_C" 0 0

#Get Virtual Machine Name/Disk Name (vm_name.qcow2)
FUNC_NAME() {
VAR_VM_NAME=""
VAR_VM_NAME_VALIDATION=1
until [ "$VAR_VM_NAME_VALIDATION" == 0 ]
do
	clear
	VAR_VM_NAME=$(whiptail --clear --ok-button "$VAR_BT_E" --cancel-button "$VAR_BT_Q" --title "$VAR_T" --backtitle "VM Name -> character only and size 4 (min) to 20 (max)" --inputbox 'VM Name:' \
	0 0 3>&2 2>&1 1>&3)
	if [ $? == 1 ]
	then
		FUNC_MAIN_MENU
	elif [ $? == 255 ]
	then
		VAR_VM_NAME_VALIDATION=1
		continue
	else
		if [ -z "$VAR_VM_NAME" ]
		then
			FUNC_INVALID_INPUT
			VAR_VM_NAME_VALIDATION=1
		elif [ "${#VAR_VM_NAME}" -le 3 ] || [ "${#VAR_VM_NAME}" -ge 20 ]
		then
			FUNC_INVALID_INPUT
			VAR_VM_NAME_VALIDATION=1
		elif ! [[ "$VAR_VM_NAME" =~ ^[a-zA-Z]+$ ]]
		then
			FUNC_INVALID_INPUT
			VAR_VM_NAME_VALIDATION=1
		else
			VAR_VM_NAME_VALIDATION=0
		fi
	fi
done
FUNC_MAIN_MENU
}

#Get RAM Memory Size (in megabytes)
FUNC_RAM() {
VAR_VM_RAM=""
VAR_VM_RAM_VALIDATION=1
until [ "$VAR_VM_RAM_VALIDATION" == 0 ]
do
        clear
        VAR_VM_RAM=$(whiptail --clear --ok-button "$VAR_BT_E" --cancel-button "$VAR_BT_Q" --title "$VAR_T" --backtitle "RAM Size -> 512Mb (min) to 8Gb (max)" --menu "RAM Size:" \
	0 0 5 "1" ": 512Mb" "2" ": 1Gb" "3" ": 2GB" "4" ": 4Gb" "5" ": 8Gb" 3>&2 2>&1 1>&3)
        if [ $? == 1 ]
	then
		FUNC_MAIN_MENU
	elif [ $? == 255 ]
	then
		VAR_VM_RAM_VALIDATION=1
		continue
	else
 		if [ "$VAR_VM_RAM" == 1 ]
        	then
                	VAR_VM_RAM_VALIDATION=0
			VAR_VM_RAM=512
        	elif [ "$VAR_VM_RAM" == 2 ]
        	then
                	VAR_VM_RAM_VALIDATION=0
			VAR_VM_RAM=1024
        	elif [ "$VAR_VM_RAM" == 3 ]
        	then
			VAR_VM_RAM_VALIDATION=0
                	VAR_VM_RAM=2048
        	elif [ "$VAR_VM_RAM" == 4 ]
		then
                	VAR_VM_RAM_VALIDATION=0
                	VAR_VM_RAM=4096
        	elif [ "$VAR_VM_RAM" == 5 ]
		then
			VAR_VM_RAM_VALIDATION=0
                	VAR_VM_RAM=8192
		else
			VAR_VM_RAM_VALIDATION=1
		fi
	fi
done
FUNC_MAIN_MENU
}

#Get CPU Total Number
FUNC_CPU() {
VAR_CPU=1
VAR_CPU_VALIDATION=1
until [ "$VAR_CPU_VALIDATION" == 0 ]
do
        clear
        VAR_CPU=$(whiptail --clear --ok-button "$VAR_BT_E" --cancel-button "$VAR_BT_Q" --title "$VAR_T" --backtitle "CPU Number -> 1 (min) to 6 (max)" --menu "CPU number:" \
	0 0 4 "1" ": 1 x CPU" "2" ": 2 x CPU" "3" ": 4 x CPU" "4" ": 6 x CPU" 3>&2 2>&1 1>&3)
	if [ $? == 1 ]
        then
                FUNC_MAIN_MENU
	elif [ $? == 255 ]
	then
		VAR_CPU_VALIDATION=1
		continue
	else
		if [ "$VAR_CPU" == 1 ]
        	then
                	VAR_CPU_VALIDATION=0
                	VAR_CPU=1
        	elif [ "$VAR_CPU" == 2 ]
        	then
                	VAR_CPU_VALIDATION=0
                	VAR_CPU=2
        	elif [ "$VAR_CPU" == 3 ]
        	then
                	VAR_CPU_VALIDATION=0
                	VAR_CPU=4
        	elif [ "$VAR_CPU" == 4 ]
        	then
                	VAR_CPU_VALIDATION=0
                	VAR_CPU=6
        	else
			VAR_CPU_VALIDATION=1
		fi
	fi
done
FUNC_MAIN_MENU
}

#Get Machine Thpe - emulated machine (pc= old pc - q35=new pc)
FUNC_MACHINE() {
VAR_MACHINE_TYPE=""
VAR_MACHINE_TYPE_VALIDATION=1
until [ "$VAR_MACHINE_TYPE_VALIDATION" == 0 ]
do
        clear
        VAR_MACHINE_TYPE=$(whiptail --clear --ok-button "$VAR_BT_E" --cancel-button "$VAR_BT_Q" --title "$VAR_T" --backtitle "Machine Type -> old, new, isa or none" --menu "Machine Type:" \
	0 0 4 "1" ": Old PC i440FX" "2" ": New PC Q35" "3" ": Very Old PC ISA" "4" ": None" 3>&2 2>&1 1>&3)
	if [ $? == 1 ]
        then
                FUNC_MAIN_MENU
	elif [ $? == 255 ]
	then
		VAR_MACHINE_TYPE_VALIDATION=1
		continue
	else
		if [ "$VAR_MACHINE_TYPE" == 1 ]
        	then
                	VAR_MACHINE_TYPE_VALIDATION=0
                	VAR_MACHINE_TYPE=pc
        	elif [ "$VAR_MACHINE_TYPE" == 2 ]
        	then
                	VAR_MACHINE_TYPE_VALIDATION=0
                	VAR_MACHINE_TYPE=q35
        	elif [ "$VAR_MACHINE_TYPE" == 3 ]
        	then
                	VAR_MACHINE_TYPE_VALIDATION=0
                	VAR_MACHINE_TYPE=isapc
        	elif [ "$VAR_MACHINE_TYPE" == 4 ]
        	then
                	VAR_MACHINE_TYPE_VALIDATION=0
                	VAR_MACHINE_TYPE=none
        	else
			VAR_MACHINE_TYPE_VALIDATION=1
                fi
        fi
done
FUNC_MAIN_MENU
}

#Get OS Type and Variant
FUNC_OS() {
VAR_OS_TYPE=""
VAR_OS_TYPE_VALIDATION=1
until [ "$VAR_OS_TYPE_VALIDATION" == 0 ]
do
	osinfo-query os | awk -F "|" '{print $1,$2}' > ./tmp.tmp
	clear
        whiptail --clear --title "$VAR_T" --backtitle "OS Type and Variant Short ID List" --textbox ./tmp.tmp --ok-button "$VAR_BT_C" 0 0
	clear
	VAR_OS_TYPE=$(whiptail --clear --ok-button "$VAR_BT_E" --cancel-button "$VAR_BT_Q" --title "$VAR_T" --backtitle "OS Type and Variant -> Short ID" --inputbox 'OS Type and Variant - Short ID:' \
	0 0 3>&2 2>&1 1>&3)
        if [ $? == 1 ]
        then
                FUNC_MAIN_MENU
        elif [ $? == 255 ]
	then
		VAR_OS_TYPE_VALIDATION=1
		continue
	else
		if [ -z "$VAR_OS_TYPE" ]
        	then
                	FUNC_INVALID_INPUT
                	VAR_OS_TYPE_VALIDATION=1
        	elif [ ! "${#VAR_OS_TYPE}" -ge 4 ]
        	then
                	FUNC_INVALID_INPUT
                	VAR_OS_TYPE_VALIDATION=1
        	else
			if [[ "$VAR_OS_TYPE" =~ [[:alpha:]] && "$VAR_OS_TYPE" =~ [[:digit:]] ]]
			then
				if cat < ./tmp.tmp | awk '{print $1}' | grep -i "$VAR_OS_TYPE"
				then
					VAR_OS_TYPE_VALIDATION=0
				else
					VAR_OS_TYPE_VALIDATION=1
				fi
			else
				VAR_OS_TYPE_VALIDATION=1
			fi
        	fi
	fi
done
FUNC_MAIN_MENU
}

#Get Graph Type (console or VNC)
FUNC_GRAPH() {
VAR_GRAPH=""
VAR_GRAPH_VALIDATION=1
until [ "$VAR_GRAPH_VALIDATION" == 0 ]
do
        clear
        VAR_GRAPH=$(whiptail --clear --ok-button "$VAR_BT_E" --cancel-button "$VAR_BT_Q" --title "$VAR_T" --backtitle "Grahp Mode -> vnc, console or none" --menu "Graph Mode:" \
	0 0 3 "1" ": VNC" "2" ": Console" "3" ": None" 3>&2 2>&1 1>&3)
        if [ $? == 1 ]
        then
		FUNC_MAIN_MENU
        elif [ $? = 255 ]
	then
		VAR_GRAPH_VALIDATION=1
		continue
	else
        	if [ "$VAR_GRAPH" == 1 ]
        	then
                	VAR_GRAPH_VALIDATION=0
                	VAR_GRAPH=vnc
        	elif [ "$VAR_GRAPH" == 2 ]
        	then
                	VAR_GRAPH_VALIDATION=0
                	VAR_GRAPH=console
        	elif [ "$VAR_GRAPH" == 3 ]
        	then
                	VAR_GRAPH_VALIDATION=0
                	VAR_GRAPH=none
        	else
                	VAR_GRAPH_VALIDATION=1
        	fi
	fi
done
FUNC_MAIN_MENU
}

#Get Boot Disk
FUNC_BOOT() {
VAR_BOOT=""
VAR_BOOT_VALIDATION=1
until [ "$VAR_BOOT_VALIDATION" == 0 ]
do
        clear
        VAR_BOOT=$(whiptail --clear --ok-button "$VAR_BT_E" --cancel-button "$VAR_BT_Q" --title "$VAR_T" --backtitle "Boot Disk -> hd, cd, none" --menu "Boot Disk:" \
	0 0 3 "1" ": HD" "2" ": CD" "3" ": None" 3>&2 2>&1 1>&3)
        if [ $? == 1 ]
        then
                FUNC_MAIN_MENU
        elif [ $? = 255 ]
        then
                VAR_BOOT_VALIDATION=1
                continue
        else
                if [ "$VAR_BOOT" == 1 ]
                then
                        VAR_BOOT_VALIDATION=0
                        VAR_BOOT=hd
                elif [ "$VAR_BOOT" == 2 ]
                then
                        VAR_BOOT_VALIDATION=0
                        VAR_BOOT=cdrom
			FUNC_CD
                elif [ "$VAR_BOOT" == 3 ]
                then
                        VAR_BOOT_VALIDATION=0
			VAR_BOOT=none
                else
                        VAR_BOOT_VALIDATION=1
                fi
        fi
done
FUNC_MAIN_MENU
}

#Get CDROM Boot ISO
FUNC_CD() {
if [ "$VAR_BOOT" == "cdrom" ]
then
	VAR_CDR=""
	VAR_CDR_VALIDATION=1
	until [ "$VAR_CDR_VALIDATION" == 0 ]
	do
        	clear
        	VAR_CDR=$(whiptail --clear --ok-button "$VAR_BT_E" --cancel-button "$VAR_BT_Q" --title "$VAR_T" --backtitle "CD Rom -> ISO file path" --inputbox 'Boot CD File:' 0 0 3>&2 2>&1 1>&3)
        	if [ $? == 1 ]
        	then
                	VAR_BOOT=""
			FUNC_BOOT
        	elif [ $? == 255 ]
        	then
               		VAR_CDR_VALIDATION=1
                	continue
        	else
                	if [ -r "$VAR_CDR" ]
                	then
                        	VAR_CDR_VALIDATION=0
				break
                	else
                        	FUNC_INVALID_INPUT
                        	VAR_CDR_VALIDATION=1
			fi
                fi
	done
else
	:
fi
FUNC_MAIN_MENU
}

#Get Disk Sizedisk size in Gigabytes
FUNC_DISK() {
VAR_DISK_SIZE=""
VAR_DISK_SIZE_VALIDATION=1
until [ "$VAR_DISK_SIZE_VALIDATION" == 0 ]
do
	clear
	VAR_DISK_SIZE=$(whiptail --clear --ok-button "$VAR_BT_E" --cancel-button "$VAR_BT_Q" --title "$VAR_T" --backtitle "Disk Size: 1Gb (min) to 40Gb (max)" --inputbox 'Disk Size (Gb):' 0 0 3>&2 2>&1 1>&3)
	if [ $? == 1 ]
	then
		FUNC_MAIN_MENU
	elif [ $? == 255 ]
	then
		VAR_DISK_SIZE_VALIDATION=1
		continue
	else
		if [ "$VAR_DISK_SIZE" -le 40 ] && [ "$VAR_DISK_SIZE" -ge 1 ]
		then
			VAR_DISK_SIZE_VALIDATION=0
		else
			FUNC_INVALID_INPUT
			VAR_DISK_SIZE_VALIDATION=1
		fi
	fi
done
FUNC_MAIN_MENU
}

#disk bus type
FUNC_BUS() {
VAR_DISK_BUS=""
VAR_DISK_BUS_VALIDATION=1
until [ "$VAR_DISK_BUS_VALIDATION" == 0 ]
do
        clear
        VAR_DISK_BUS=$(whiptail --clear --ok-button "$VAR_BT_E" --cancel-button "$VAR_BT_Q" --title "$VAR_T" --backtitle "Disk Bus -> ide, sata, scsi or virtio" --menu "Disk Bus:" \
	0 0 4 "1" ": IDE" "2" ": SATA" "3" ": SCSI" "4" ": Virtio" 3>&2 2>&1 1>&3)
        if [ $? == 1 ]
        then
                FUNC_MAIN_MENU
        elif [ $? = 255 ]
        then
                VAR_DISK_BUS_VALIDATION=1
                continue
        else
                if [ "$VAR_DISK_BUS" == 1 ]
                then
                        VAR_DISK_BUS_VALIDATION=0
                        VAR_DISK_BUS=ide
                elif [ "$VAR_DISK_BUS" == 2 ]
                then
                        VAR_DISK_BUS_VALIDATION=0
                        VAR_DISK_BUS=sata
                elif [ "$VAR_DISK_BUS" == 3 ]
                then
                        VAR_DISK_BUS_VALIDATION=0
                        VAR_DISK_BUS=scsi
		elif [ "$VAR_DISK_BUS" == 4 ]
                then
                        VAR_DISK_BUS_VALIDATION=0
                        VAR_DISK_BUS=virtio
                else
                        VAR_DISK_BUS_VALIDATION=1
                fi
        fi
done
FUNC_MAIN_MENU
}

#network nic model (bridge mode)
FUNC_NET() {
VAR_NET_MODEL=""
VAR_NET_MODEL_VALIDATION=1
until [ "$VAR_NET_MODEL_VALIDATION" == 0 ]
do
        clear
        VAR_NET_MODEL=$(whiptail --clear --ok-button "$VAR_BT_E" --cancel-button "$VAR_BT_Q" --title "$VAR_T" --backtitle "NIC Model (bridge mode): e1000, rtl8139 or virtio" --menu "Boot Disk:" \
	0 0 3 "1" ": e1000" "2" ": rtl8139" "3" ": virtio" 3>&2 2>&1 1>&3)
        if [ $? == 1 ]
        then
                FUNC_MAIN_MENU
        elif [ $? = 255 ]
        then
                VAR_NET_MODEL_VALIDATION=1
                continue
        else
                if [ "$VAR_NET_MODEL" == 1 ]
                then
                        VAR_NET_MODEL_VALIDATION=0
                        VAR_NET_MODEL=e1000
                elif [ "$VAR_NET_MODEL" == 2 ]
                then
                        VAR_NET_MODEL_VALIDATION=0
                        VAR_NET_MODEL=rtl8139
                elif [ "$VAR_NET_MODEL" == 3 ]
                then
                        VAR_NET_MODEL_VALIDATION=0
                        VAR_NET_MODEL=virtio
                else
                        VAR_NET_MODEL_VALIDATION=1
                fi
        fi
done
FUNC_MAIN_MENU
}

FUNC_CREATE() {
if [ "$VAR_VM_NAME" = "" ] || [ "$VAR_VM_RAM" = "" ] || [ "$VAR_CPU" = "" ] || [ "$VAR_MACHINE_TYPE" = "" ] || \
[ "$VAR_OS_TYPE" = "" ] || [ "$VAR_GRAPH" = "" ] || [ "$VAR_BOOT" = "" ] || \
[ "$VAR_DISK_SIZE" = "" ] || [ "$VAR_DISK_BUS" = "" ] || [ "$VAR_NET_MODEL" = "" ]
then
	FUNC_FIELD_EMPTY
        FUNC_MAIN_MENU
else
	clear
	echo "################################"
	echo "# Creating VM. Please, wait... #"
	echo "################################"
	VAR_OS=$(printf '%s\n' "${VAR_OS_TYPE//[[:digit:]]/}")
	if [ "$VAR_BOOT" == "hd" ] || [ "$VAR_BOOT" == "none" ]
	then
		virt-install -n "$VAR_VM_NAME" --boot "$VAR_BOOT" --machine "$VAR_MACHINE_TYPE" --ram "$VAR_VM_RAM" --os-type "$VAR_OS" --os-variant "$VAR_OS_TYPE" \
		--vcpus "$VAR_CPU" --disk path=/var/lib/libvirt/images/"$VAR_VM_NAME".qcow2,bus="$VAR_DISK_BUS",size="$VAR_DISK_SIZE" --graphics "$VAR_GRAPH" \
		--network bridge=pnet0,model="$VAR_NET_MODEL"
		exit 0
	elif [ "$VAR_BOOT" == "cdrom" ]
	then
		virt-install -n "$VAR_VM_NAME" --boot "$VAR_BOOT" --machine "$VAR_MACHINE_TYPE" --ram "$VAR_VM_RAM" --os-type "$VAR_OS" --os-variant "$VAR_OS_TYPE" \
		--vcpus "$VAR_CPU" --cdrom "$VAR_CDR" --disk path=/var/lib/libvirt/images/"$VAR_VM_NAME".qcow2,bus="$VAR_DISK_BUS",size="$VAR_DISK_SIZE" --graphics "$VAR_GRAPH" \
		--network bridge=pnet0,model="$VAR_NET_MODEL"
		exit 0
	else
		:
	fi
fi
}

#Open begin main menu
FUNC_MAIN_MENU
exit 0
