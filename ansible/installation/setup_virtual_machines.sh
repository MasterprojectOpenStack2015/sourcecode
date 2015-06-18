#!/bin/bash

# read the configuration file
source config/installation_configuration.sh

# create virtual machines
for virtual_machine_name in `tools/vm_names`
do 
	virsh start $virtual_machine_name
done







