#!/bin/bash

# read the configuration file
source config/installation_configuration.sh

# we follow this tutorial
# http://serverascode.com/2014/03/17/trusty-libvirt.html

# Checkout cloud-localds
if [ ! -f ~/cloud-utils/bin/cloud-localds ]
then
	( 	cd ~ ; \
	  	bzr branch lp:cloud-utils
	)
fi

# create virtual machines
for virtual_machine_name in `tools/vm_names`
do 
	tools/create_vm_named $virtual_machine_name
done
