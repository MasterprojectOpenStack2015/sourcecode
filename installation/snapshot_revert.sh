#!/bin/bash

if [ "$1" == "" ]
then
  echo "------------------------------------------------------------"
  echo "Available snapshots: "
  echo "------------------------------------------------------------"

  tools/list_domains | while read virtual_machine_name; do 
    echo
    echo $virtual_machine_name
    virsh snapshot-list $virtual_machine_name || exit 2
  done

  echo "------------------------------------------------------------"
  echo "Enter snapshot name: "
  read snapshot_name
else 
  snapshot_name=$1
fi

tools/shutdown_all_vms


tools/list_domains | while read virtual_machine_name; do 
	echo "virsh snapshot-revert $virtual_machine_name $snapshot_name"
	virsh snapshot-revert $virtual_machine_name $snapshot_name || exit 3
done
echo "------------------------------------------------------------"
echo "All VMs restored to snapshot "$snapshot_name
echo "If logged in in Horizon, please re-login after restore."
echo "------------------------------------------------------------"

tools/start_all_vms
tools/print_advice
