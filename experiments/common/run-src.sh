#!/bin/bash

PATH=`dirname "$0"`/../common:`dirname "$0"`/../../installaion/tools:$PATH
export logging_level=${1:1}
experiment_folder=`pwd`
experiment_folder=`filename "$experiment_folder"`
export variables=`create_variables_file "$experiment_folder"`

