#!/bin/sh

# We use the directory where this file is located in.
# This way we can use the local paths.
cd `dirname $0`

tools/start_stepping

date1=$(date +"%s")

tools/step ./install_tools.sh
tools/step ./install_ansible.sh
tools/step ./create_ssh_keys.sh
tools/step ./install_lib_virt.sh
tools/step ./create_virtual_networks.sh
tools/step ./create_virtual_machine_image.sh
tools/step ./create_virtual_machines.sh
tools/step ./configure_ansible_for_vms.sh
tools/step ./wait_for_virtual_machines_to_start.sh
tools/step ./setup_virtual_machines.sh
tools/step ./remove_aptcache_vm.sh
tools/step ./snapshot_virtual_machines.sh initial


date2=$(date +"%s")
diff=$(($date2-$date1))
echo "Done. Installation took $(($diff / 60))m $(($diff % 60))s."
echo "Horizon URL: http://controller/horizon/ (Wait a few seconds for VMs to come back up)"
echo "Logins are demo/demo or admin/admin if not otherwise specified in config"
echo "------------------------------------------------------------"