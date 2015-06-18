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
	rm -rf $downloaded_vm_image_folder/*
	# download the ubuntu cloud image
	( cd $downloaded_vm_image_folder ; wget $vm_image_url ) || \
	( echo "error downloading $vm_image_url"; exit 1 )
fi



# now we follow the tutorial to create disk images out of the downloaded trusty server
# http://serverascode.com/2014/03/17/trusty-libvirt.html

if [ ! -f $vm_base_image_file ]
then
	rm -f ${vm_base_image_file}.dist
	rm -f ${vm_base_image_file}.original
	rm -f ${vm_base_image_file}.tmp
	# link the image file
	ln -s $downloaded_vm_image_folder/* ${vm_base_image_file}.dist
	# uncompress the image file
	qemu-img convert -O qcow2 ${vm_base_image_file}.dist ${vm_base_image_file}.original
	# increase the image file size by 8GB
	qemu-img resize ${vm_base_image_file}.original +8G
	# Create a snapshotted backing file which will allow us to keep the original image pristine.
	qemu-img create -f qcow2 -b ${vm_base_image_file}.original ${vm_base_image_file}.tmp
	
	# we are done. The last operation is to create the vm_base_image_file
	# this is the last statement within this if condition
	mv $vm_base_image_file.tmp $vm_base_image_file || exit 2
fi

