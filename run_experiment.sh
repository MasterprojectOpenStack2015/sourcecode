#!/bin/bash

if [ "${#@}" == "0" ] || [ "$1" == "--help" ] || [ "$1" == "-h" ]
then
  echo 'Which EXPERIMENT shall be run?'
  for experiment in `$0 --list`
  do
    echo "  $0 `filename $experiment`"
  done
  echo 
  echo 'Addidionally you can pass verbosity arguments:'
  echo "  For overview output:"
  echo "    $0 EXPERIMENT -v"
  echo "  For more information about what happens:"
  echo "    $0 EXPERIMENT -vv"
  echo "  To see everything that could be interesting:"
  echo "    $0 EXPERIMENT -vv"
  echo
  echo "To list all experiments do"
  echo "  $0 --list"
  echo "  $0 -l"
  echo
  exit 0
elif [ "$1" == "--list" ] || [ "$1" == "-l" ]
then
  for experiment in `dirname $0`/experiments/*
  do
  	if [ -f "$experiment/run.sh" ]
    then
      echo "`filename $experiment`"
    fi
  done
  exit 0
fi

experiment=$1
experiment_folder=`dirname $0`/experiments/$1
experiment_file=`dirname $0`/experiments/$1/run.sh
if [ ! -f "$experiment_file" ]
then
  echo "ERROR: experiment \"$experiment_file\" not found."
  exit 1
fi

shift

cd $experiment_folder
./run.sh $@
