#!/bin/bash
clear
echo "Checking Ansible Syntax file $1. Please, wait..."
for VAR_FILE in *.yml
do
        ansible-playbook -v ./$VAR_FILE --syntax-check;
done
exit 0
