#!/bin/bash

heading HEALING FAULT

# for loop from http://stackoverflow.com/questions/255898/how-to-iterate-over-arguments-in-bash-script

for node in "$@"
do
  subheading "restarting Storage Node $node"
  virsh start $node | log -vvv -i
done

for node in "$@"
do
  subheading "waiting for $node to come up again"
  until [ "`ssh-keyscan -H $node 2> /dev/null`" != "" ]
  do
    sleep 1
    log -vvv -n .
  done
done

