#!/bin/bash

source config/installation_configuration.sh

# copy ansible hosts file to /etc/ansible/
sudo rm -f /etc/ansible/hosts
# sudo and piping into files http://stackoverflow.com/a/82278/1320237
sudo sh -c 'tools/config_variables | tools/render_template config/ansible/hosts > /etc/ansible/hosts'

# copy ansible config file to /etc/ansible/
sudo rm -f /etc/ansible/ansible.cfg
sudo ln -s `realpath config/ansible/ansible.cfg` /etc/ansible/ansible.cfg

# create an .yml file for the configuration
mkdir -p config/ansible/playbooks/roles/config/vars
variables_file=config/ansible/playbooks/roles/config/vars/main.yml
echo "---
config:" > $variables_file
# for a valid variable example read http://stackoverflow.com/a/26640550/1320237
tools/config_variables | sed 's/^\([^=]*\)=/  \1: /g' >> $variables_file

