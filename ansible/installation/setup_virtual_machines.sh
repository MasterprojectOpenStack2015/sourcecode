#!/bin/bash

# read the configuration file
source config/installation_configuration.sh

# copy ansible hosts and config file to /etc/ansible/
sudo rm -f /etc/ansible/hosts
sudo ln -s `realpath config/ansible/hosts` /etc/ansible/hosts
sudo rm -f /etc/ansible/ansible.cfg
sudo ln -s `realpath config/ansible/ansible.cfg` /etc/ansible/ansible.cfg

# execute playbooks on ansible hosts
# http://docs.openstack.org/kilo/install-guide/install/apt/content/ch_basic_environment.html

for playbook in config/ansible/playbooks/*
do
	ansible-playbook $playbook || exit 1
done


