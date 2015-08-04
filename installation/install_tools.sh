#!/bin/bash

# for the filename command
tools/install_package wcstools

# for the realpath command
tools/install_package realpath

# for virtual machine creation
# see the tutorial http://serverascode.com/2014/03/17/trusty-libvirt.html
tools/install_package bzr

# for the virtual machine manager
tools/install_package virt-manager

# for pip
tools/install_package python-pip

# install Jinja2 for template instanciation
if ! python -c "import jinja2"
then
	sudo pip install --upgrade Jinja2
fi


