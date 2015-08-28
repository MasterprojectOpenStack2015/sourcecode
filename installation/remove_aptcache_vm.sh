#!/bin/bash

virsh destroy aptcache 2> /dev/null
virsh undefine aptcache --snapshots-metadata 2> /dev/null