#!/bin/bash

#note: this is not yet added to main install flow - should at least on ubuntu be able to fix the kernel setting itself

if [ -f /sys/module/kvm_intel/parameters/nested ]
then
	if [[ `cat /sys/module/kvm_intel/parameters/nested` == "Y" ]]
	then
		echo "nested virtualisation support active - all is well"
	else
		echo "------------------------------------------------------------------------------"
		echo "-----------------------nested virtualsation support missing!------------------"
		echo "please set kernel module option kvm_intel.nested = 1"
		exit 1
	fi
else 
	echo "No kvm_intel kernel module found - if you are running AMD, time to fix check_nested_support.sh for that"
	exit 1
fi
