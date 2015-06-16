#!/bin/bash

# read the configuration file
source config/installation_configuration.sh

# ready the directory for download
downloaded_vm_image_folder=$downloads_directory/images/vm
mkdir -p $downloaded_vm_image_folder

# test if we need a download
## multiple arguments to if http://stackoverflow.com/a/16203126
if [ ! -f $downloaded_vm_image_folder/* ] || \
   [ `md5sum $downloaded_vm_image_folder/* | grep -o -E '^\S{32}'` != $vm_image_md5_hash ]
then
	# remove any corrupt file
	rm -r $downloaded_vm_image_folder/*
	# download the ubuntu cloud image
	( cd $downloaded_vm_image_folder ; wget $vm_image_url )
	ln -s $downloaded_vm_image_folder/* $vm_base_image_file
fi

# create virtual machines
for virtual_machine_name in /config/vm/* 
do 
	tools/create_vm_named network $virtual_machine_name
done
