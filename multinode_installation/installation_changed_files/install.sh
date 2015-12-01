#!/bin/sh

# We use the directory where this file is located in.
# This way we can use the local paths.
cd `dirname $0`

tools/start_stepping

date_of_installation_start=$(date +"%s")

tools/step ./create_ssh_keys.sh
tools/step ./create_virtual_networks.sh
tools/step ./create_virtual_machine_image.sh
tools/step ./create_virtual_machines.sh
tools/step ./configure_ansible_for_vms.sh
tools/step ./wait_for_virtual_machines_to_start.sh
tools/step ./setup_virtual_machines.sh
tools/step ./remove_aptcache_vm.sh
tools/step ./snapshot_virtual_machines.sh initial

date_of_installation_end=$(date +"%s")
installation_duration=$(($date_of_installation_end-$date_of_installation_start))
echo ---------------------------------------------------------
echo "Installation took $(($installation_duration / 60))m $(($installation_duration % 60))s."
tools/print_advice

