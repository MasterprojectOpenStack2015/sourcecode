#!/bin/bash

heading CREATING FAULT

for node in "$@"
do
  subheading killing Storage Node $node
  virsh destroy $node | log -vvv -i
done

