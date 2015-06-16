#!/bin/sh



###############################################################################
###### configuration for download

# downloads_directory is the directory where to download the image files to
downloads_directory='/tmp/openstack_installation/downloads'

# vm_image_url is the url for the image in the vms.
# When you change this also change vm_image_md5_hash.
vm_image_url='https://cloud-images.ubuntu.com/trusty/20150615/trusty-server-cloudimg-amd64-disk1.img'

# vm_image_md5_hash is the md5 hash of the vm image.
# It is used to avoid duplicate downloads.
# If this hash does not fit, the image will be downloaded
# every time the vms are set up.
vm_image_md5_hash=d5c70c7219858a3d4fe13dc522f6f8e2

###############################################################################
###### configuration for the vms

# vm_images_directory is the folder where the image files of the virtual
# machines are stored.
# If you change this path be aware that the paths in the xml files need to be 
# changed as well.
vm_images_directory='/tmp/openstack_installation/images'



###############################################################################
###### setup to make variables valid

# create the downloads directory
mkdir -p $downloads_directory
mkdir -p $vm_images_directory


