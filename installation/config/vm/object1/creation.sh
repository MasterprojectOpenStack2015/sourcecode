#!/bin/bash


# check if we have a configuration directory variable
if [ -z "$configuration_directory" ]
then
  exit 41
fi

source $configuration_directory/installation_configuration.sh

# Following the tutorial at 
# http://docs.fedoraproject.org/en-US/Fedora/13/html/Virtualization_Guide/sect-Virtualization-Virtualized_block_devices-Adding_storage_devices_to_guests.html
# to create new partitions for the object storage
# with a flovour of https://docs.fedoraproject.org/en-US/Fedora/18/html/Virtualization_Administration_Guide/sect-Virtualization-Adding_storage_devices_to_guests-Adding_hard_drives_and_other_block_devices_to_a_guest.html


# 1.  Create an empty container file or using an existing file container (such as an ISO file).
# 1.a Create a sparse file using the dd command. Sparse files are not recommended due to data integrity and performance issues. Sparse files are created much faster and can used for testing but should not be used in production environments.

storage_file1=$this_vm_files_folder/storage1.img
storage_file2=$this_vm_files_folder/storage2.img

echo storage_file1=$storage_file1 >> $variables_file
echo storage_file2=$storage_file2 >> $variables_file
 
dd if=/dev/zero of=$storage_file1 bs=1M seek=4096 count=0 \
|| exit 42
dd if=/dev/zero of=$storage_file2 bs=1M seek=4096 count=0 \
|| exit 43


