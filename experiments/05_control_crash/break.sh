#!/bin/bash

heading CREATING FAULT

subheading shutting the controller down
virsh shutdown controller | log -vvv --input 

subheading "Waiting for the controller to shut down."


list_domains --active | log -vvv --input "Active domains:"

while list_domains --active | grep -q controller
do
  sleep 1
  log -vvv .
done



