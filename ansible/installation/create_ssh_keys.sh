#!/bin/bash

# read the configuration file
source config/installation_configuration.sh

if [ ! -d ~/.ssh ]
then
	mkdir ~/.ssh &>/dev/null
fi

if [ ! -f  $authorized_private_key_file_for_access_to_the_vm ] 
then
	ssh-keygen -t rsa -f $authorized_private_key_file_for_access_to_the_vm -N ""
fi

if [ ! -f  $authorized_public_key_file_for_access_to_the_vm ] 
then
	ssh-keygen -y -f $authorized_private_key_file_for_access_to_the_vm > $authorized_public_key_file_for_access_to_the_vm 
fi

cat $authorized_public_key_file_for_access_to_the_vm | tools/append_once.py ~/.ssh/authorized_keys $authorized_public_key_file_for_access_to_the_vm
chmod 600 ~/.ssh/authorized_keys

