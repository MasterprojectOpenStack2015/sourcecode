#!/bin/bash

# start virtual machines
for virtual_machine_name in `tools/vm_names`
do 
	virsh start $virtual_machine_name || exit 2
done

# NOTE: The following steps can be done with ansible

# copy ssh keys of virtual machines into known hosts file
for ip_address in `tools/list_ips`
do
	# wait until we get a connection and then
	# copy the ssh key into the known hosts file
	# until loop: http://unix.stackexchange.com/a/68199
	until [ "`ssh-keyscan -H $ip_address 2> /dev/null`" != "" ]
	do
		sleep 1
		echo "Waiting for $ip_address"
	done
	# insert the ssh key of the host into ~/.ssh/known_hosts, 
	# so we do not need to type "yes" and do not get these messages:
	# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	# @       WARNING: POSSIBLE DNS SPOOFING DETECTED!          @
	# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	# @    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
	# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	ssh-keyscan -H $ip_address | tools/append_once.py ~/.ssh/known_hosts "$ip_address"
done




