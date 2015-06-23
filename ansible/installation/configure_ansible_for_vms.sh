#!/bin/bash

# copy ansible hosts file to /etc/ansible/
sudo rm -f /etc/ansible/hosts
# sudo and piping into files http://stackoverflow.com/a/82278/1320237
sudo sh -c 'tools/config_variables | tools/render_template config/ansible/hosts > /etc/ansible/hosts'

# copy ansible config file to /etc/ansible/
sudo rm -f /etc/ansible/ansible.cfg
sudo ln -s `realpath config/ansible/ansible.cfg` /etc/ansible/ansible.cfg




