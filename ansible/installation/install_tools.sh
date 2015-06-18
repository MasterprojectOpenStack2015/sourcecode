#!/bin/bash

if ! type filename > /dev/null
then
	# for the filename command
	sudo apt-get -y install wcstools
fi

if ! type realpath > /dev/null
then
	# for the filename command
	sudo apt-get -y install realpath
fi

if ! type bzr  > /dev/null
then
	# for virtual machine creation
	# see the tutorial http://serverascode.com/2014/03/17/trusty-libvirt.html
	sudo apt-get -y install bzr
fi
