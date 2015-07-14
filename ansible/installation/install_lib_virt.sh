#!/bin/bash

if ! tools/package_is_installed qemu-kvm
then 
	# install qemu-kvm before libvirt
	# This way libvirt recognized kvm.
	# Otherwise this error occurs:
	# error: Failed to define domain from /tmp/openstack_installation/images/network/creation.xml
	# error: unknown OS type hvm
	sudo apt-get -y remove virtinst libvirt-bin
	sudo apt-get install qemu-kvm || exit 1
fi

# install libvirt

tools/install_package virtinst || exit 2

tools/install_package libvirt-bin || exit 3


if [ -n "`virsh list 2>&1 | grep 'Permission denied'`" ]
then
	# permission denied
	# http://wiki.libvirt.org/page/Failed_to_connect_to_the_hypervisor#Permission_denied
	echo "setting permissions for all users to use the \"virsh\" command"
	sudo sed '/unix_sock_rw_perms\s*=.*/c\unix_sock_rw_perms = "0777" # replaced by install_lib_virt.sh' /etc/libvirt/libvirtd.conf
	sudo service libvirt-bin start
fi


