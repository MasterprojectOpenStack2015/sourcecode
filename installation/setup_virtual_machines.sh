#!/bin/bash

# execute playbooks on ansible hosts
source config/installation_configuration.sh

ansible-playbook $ansible_playbooks_directory/openstack_installation.yml --ask-sudo-pass || exit 1

