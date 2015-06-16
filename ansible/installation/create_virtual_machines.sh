#!/bin/bash

# read the configuration file
source config/installation_configuration.sh

# ready the directory for download
downloaded_vm_image_folder=$downloads_directory/images/vm
mkdir -p $downloaded_vm_image_folder

## multiple arguments to if http://stackoverflow.com/a/16203126

if [ ! -f $downloaded_vm_image_folder/* ] || \
   [ `md5sum $downloaded_vm_image_folder/* | grep -o -E '^\S{32}'` != $vm_image_md5_hash ]
then
	# remove any corrupt file
	rm -r $downloaded_vm_image_folder/*
	# download the ubuntu cloud image
	( cd $downloaded_vm_image_folder ; wget $vm_image_url )
fi

virsh define config/vm/network.xml

