#!/bin/bash

(
  cd "`dirname $0`/installation/"
  ./snapshot_revert.sh $*
)
