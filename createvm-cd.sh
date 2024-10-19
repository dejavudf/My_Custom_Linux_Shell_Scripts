#!/bin/bash
#vm name/host and disk name (.qcow2)
vm=pfsense
#ram memory (in megabytes)
ram=1024
#cpu number
cpu=2
#os type
ostype=freebsd
#os variant (specific version)
osvariant=freebsd10
#emulated machine (pc= old pc - q35=new pc)
machine=q35
#graph type (console)
graph=vnc
#boot from
bt=cdrom
#disk size in Gigabytes
disksize=8
#disk bus type
diskbus=virtio
#cdrom (--cdrom)
cdr=/data/ISOs/pfsense/pfSense-CE-2.5.2-RELEASE-amd64.iso
#network bridge interface
netbridge1=pnet0
netbridge2=br0
#network nic model
netmodel=virtio


virt-install -n $vm --boot $bt --machine $machine --ram $ram --os-type $ostype --os-variant $osvariant --vcpus $cpu --cdrom $cdr --disk path=/var/lib/libvirt/images/$vm.qcow2,bus=$diskbus,size=$disksize --graphics $graph --network bridge=$netbridge1,model=$netmodel --network bridge=$netbridge2,model=$netmodel
