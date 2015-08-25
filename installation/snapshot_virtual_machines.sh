#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "One parameter (snapshot name) needed"
    exit 2
fi

for virtual_machine_name in `tools/vm_names`
do 
	virsh snapshot-create-as $virtual_machine_name --name $1 || exit 2
	virsh snapshot-list $virtual_machine_name
done

echo "All VMs snapshotted as "$1

