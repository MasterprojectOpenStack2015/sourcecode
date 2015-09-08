#!/bin/bash

(
  cd "`dirname $0`/installation/"
  ./install.sh $*
)
