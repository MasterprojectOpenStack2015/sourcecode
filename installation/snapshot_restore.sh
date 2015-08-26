#!/bin/bash

echo "------------------------------------------------------------"
echo "Available snapshots: "
echo "------------------------------------------------------------"


for virtual_machine_name in `tools/vm_names`
do 
	virsh snapshot-list $virtual_machine_name || exit 2
done
echo "------------------------------------------------------------"
echo "Enter snapshot name: "
read snapshot_name

./tools/shutdown_all_vms

for virtual_machine_name in `tools/vm_names`
do 
	echo "virsh snapshot-revert $virtual_machine_name $snapshot_name"
	virsh snapshot-revert $virtual_machine_name $snapshot_name || exit 2
done
echo "------------------------------------------------------------"
echo "All VMs restored to snapshot "$snapshot_name
echo "If logged in in Horizon, please re-login after restore."
echo "------------------------------------------------------------"

./tools/start_all_vms
