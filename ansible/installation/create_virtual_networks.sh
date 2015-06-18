#!/bin/bash

# check if we have networks
if [ "`ls config/network`" != "" ]
then 
	# create virtual networks
	for virtual_network_xml in config/network/*.xml
	do 
		echo processing $virtual_network_xml
		network_name=$(basename --suffix=".xml" $virtual_network_xml)
		if virsh net-info $network_name &> /dev/null
		then
			echo "network $virtual_network already exists, deleting it..."
			virsh net-destroy $network_name
		fi
		echo "create network"
		virsh net-create $virtual_network_xml
	done
fi
