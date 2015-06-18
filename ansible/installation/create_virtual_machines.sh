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

# Create a user data file
if [ -f $user_data_cloud_config_file ]
then
	rm $user_data_cloud_config_file
fi

echo "#cloud-config
password: $authorized_password_for_access_to_the_vm
chpasswd: { expire: False }
ssh_pwauth: True
ssh_authorized_keys:
  - `cat $authorized_public_key_file_for_access_to_the_vm`" > $user_data_cloud_config_file

# Build the user-data image
# Now we convert the $user_data_cloud_config_file file to an ISO file.
~/cloud-utils/bin/cloud-localds $user_data_cloud_config_image $user_data_cloud_config_file

# create virtual machines
for virtual_machine_name in `tools/vm_names`
do 
	tools/create_vm_named $virtual_machine_name
done
