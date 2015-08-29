#!/bin/bash

virsh destroy aptcache
virsh undefine aptcache --snapshots-metadata