#!/bin/sh

# if ansible is not installed, yet
if ! type ansible >> /dev/null
then
	# install ansible
	sudo apt-add-repository -y ppa:ansible/ansible
	sudo apt-get -y update
	sudo apt-get -y install software-properties-common ansible
fi

# copy the ansible configuration to /etc/ansible
if [ -d /etc/ansible ]
then
	sudo cp ./config/ansible.cfg /etc/ansible
fi
