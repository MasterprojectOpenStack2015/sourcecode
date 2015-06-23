#!/bin/bash

if ! dpkg -s virtinst >> /dev/null 2>&1
then
	sudo apt-get -y install virtinst
fi

if ! dpkg -s libvirt-bin >> /dev/null 2>&1
then
	sudo apt-get -y install libvirt-bin
fi


