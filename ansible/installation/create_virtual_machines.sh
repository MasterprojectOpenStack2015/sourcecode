#!/bin/bash

# read the configuration file
source config/installation_configuration.sh

# ready the directory for download
vm_image_folder=$downloads_directory/images/vm
mkdir -p $vm_image_folder

## multiple arguments to if http://stackoverflow.com/a/16203126

if [ ! -f $vm_image_folder/* ] || [ `md5sum $vm_image_folder/* | grep -o -E '^\S{32}'` !=  ]
then
	# remove any corrupt file
	rm -r $vm_image_folder/*
	# download the ubuntu cloud image
	( cd $vm_image_folder ; wget $vm_image_url )
fi



