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
roles_variables_directory=$generated_ansible_roles_directory/config/vars
sudo mkdir -p $roles_variables_directory
variables_file=$roles_variables_directory/main.yml
sudo sh -c "echo '---
config:' > $variables_file"
# for a valid variable example read http://stackoverflow.com/a/26640550/1320237
sudo sh -c "tools/config_variables | sed 's/^\([^=]*\)=/  \1: /g' >> $variables_file"

