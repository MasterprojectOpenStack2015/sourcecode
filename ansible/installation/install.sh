#!/bin/sh

# We use the directory where this file is located in.
# This way we can use the local paths.
cd `dirname $0`

./install_tools.sh && \
./install_ansible.sh && \
./create_ssh_keys.sh && \
./install_lib_virt.sh && \
./create_virtual_machine_image.sh && \
./create_virtual_machines.sh && \
./setup_virtual_machines.sh && \
./snapshot_virtual_machines.sh



