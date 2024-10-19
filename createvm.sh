#!/bin/bash
#vm name/host and disk name (.qcow2)
vm=template
#ram memory (in megabytes)
ram=1024
#cpu number
cpu=1
#os type
ostype=linux
#os variant (specific version)
osvariant=debian8
#emulated machine (pc= old pc - q35=new pc)
machine=pc
#graph type (console)
graph=vnc
#boot from
bt=hd
#disk size in Gigabytes
disksize=1
#disk bus type
diskbus=virtio
#cdrom (--cdrom)
cdr=/teste/teste.iso
#network bridge interface
netbridge=pnet0
#network nic model
netmodel=virtio

virt-install -n $vm --boot $bt --machine $machine --ram $ram --os-type $ostype --os-variant $osvariant --vcpus $cpu --disk path=/var/lib/libvirt/images/$vm.qcow2,bus=$diskbus,size=$disksize --graphics $graph --network bridge=$netbridge,model=$netmodel
