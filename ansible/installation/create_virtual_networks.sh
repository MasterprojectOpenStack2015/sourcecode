#!/bin/bash

# check if we have networks
if [ "`ls config/network 2>>/dev/null`" != "" ]
then 
  # create virtual networks
  for virtual_network_xml in config/network/*.xml
  do 
    echo Processing $virtual_network_xml
    network_name=$(basename --suffix=".xml" $virtual_network_xml)
    if virsh net-info $network_name &> /dev/null
    then
      echo "Network \"${network_name}\" already exists, removing it."
      virsh net-destroy $network_name 2> /dev/null
      virsh net-undefine $network_name 2> /dev/null
    fi
    echo "Creating network \"${network_name}\""
    virsh net-create $virtual_network_xml || exit 1
  done
fi
