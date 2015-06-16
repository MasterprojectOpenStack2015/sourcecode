#!/bin/sh

./install_ansible.sh && \
./create_ssh_keys.sh && \
./install_lib_virt.sh && \
./create_virtual_machines.sh



