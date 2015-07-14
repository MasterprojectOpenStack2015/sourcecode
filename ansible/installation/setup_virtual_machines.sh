#!/bin/bash

# execute playbooks on ansible hosts
# http://docs.openstack.org/kilo/install-guide/install/apt/content/ch_basic_environment.html
#for playbook in config/ansible/playbooks/setup_*.yml
#do
#	ansible-playbook $playbook || exit 1
#done

ansible-playbook config/ansible/playbooks/openstack_installation.yml --ask-sudo-pass || exit 1

