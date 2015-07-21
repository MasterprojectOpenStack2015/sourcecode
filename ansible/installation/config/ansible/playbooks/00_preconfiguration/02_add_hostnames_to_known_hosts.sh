#!/bin/bash

tools="$1"

for ip_address in `$tools/list_ips`
do
	# insert the ssh key of the host into ~/.ssh/known_hosts, 
	# so we do not need to type "yes" and do not get these messages:
	# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	# @       WARNING: POSSIBLE DNS SPOOFING DETECTED!          @
	# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	# @    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
	# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	
	remote_user=`$tools/ansible_remote_user`
	hostname=`ssh $remote_user@$ip_address hostname`
	ssh-keygen -f ~/.ssh/known_hosts -R $hostname
	ssh-keyscan -H $hostname | tools/append_once.py ~/.ssh/known_hosts "$ip_address" || exit 1
done



