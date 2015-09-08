#!/bin/bash

(
  cd "`dirname $0`/installation/"
  ./snapshot_virtual_machines.sh $*
)
