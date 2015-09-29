#!/bin/bash

heading CREATING FAULT

subheading shutting the controller down
virsh shutdown controller | log -vvv --input 

subheading "Waiting for the controller to disappear."


list_domains | log -vvv --input "active domains:"

while list_domains | grep -q controller
do
  sleep 1
  log -vvv .
done



