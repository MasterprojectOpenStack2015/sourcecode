#!/bin/bash

heading Running checks

source "$variables"

subheading pinging the first created instance
ping_check $FLOATING_IP1 $FLOATING_IP1

log -vvv

# TODO: second instance: show and compare states
# TODO: add API calls
#if [ -z "$FLOATING_IP2" ] 
#then
#	subheading "Second instance doesn't exist yet, skipping..."
#else	
#	subheading pinging the second, not scheduled instance
#	ping_check $FLOATING_IP2
#	log -vvv
#fi

subheading "Service state according to nova on controller:"

ssh ubuntu@controller "source admin-openrc.sh && nova service-list" | grep -v controller

#alternatively, disable stepping
log -vv -vvv "Also look at Horizon, as both user and admin!"
