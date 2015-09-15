#!/bin/bash


# check if we have a configuration directory variable
if [ -z "$configuration_directory" ]
then
  exit 41
fi

source $configuration_directory/installation_configuration.sh

if [ ! -d "$apt_cache_dir" ]
then
  mkdir --parents --mode=777 "$apt_cache_dir";
else 
  echo "using existing apt_cache_dir $apt_cache_dir";
fi;

