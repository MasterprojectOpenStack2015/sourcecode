#!/bin/bash

echo "------------------------------------------------------------"
echo "Available snapshots: "
echo "------------------------------------------------------------"

list_domains() {
	virsh list --all | grep "running\|shut off" | awk '{ print $2}'
}

list_domains | while read virtual_machine_name; do 
	echo
	echo $virtual_machine_name
	virsh snapshot-list $virtual_machine_name || exit 2
done
echo "------------------------------------------------------------"
echo "Enter snapshot name: "
read snapshot_name


./tools/shutdown_all_vms


list_domains | while read virtual_machine_name; do 
	echo "virsh snapshot-revert $virtual_machine_name $snapshot_name"
	virsh snapshot-revert $virtual_machine_name $snapshot_name || exit 2
done
echo "------------------------------------------------------------"
echo "All VMs restored to snapshot "$snapshot_name
echo "If logged in in Horizon, please re-login after restore."
echo "------------------------------------------------------------"

./tools/start_all_vms
