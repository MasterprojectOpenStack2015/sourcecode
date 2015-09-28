#!/bin/bash

source `dirname $0`/../common/run-src.sh

#TODO: echo a description, wait for user confirmation?

experiment_heading "Crash Objct Storage"

./setup.sh
./run_checks.sh download_file.yml


echo "File uploaded and downloaded. Press enter to continue to next step"; read -s
./break1.sh
./run_checks.sh download_file.yml
echo "Object node 1 crashed, file downloaded. Press enter to continue to next step"; read -s
./heal1.sh
./run_checks.sh download_file.yml
echo "Object node 1 restarted, file downloaded. It still may take a while until the cluster has reconnected and is fully responsive."


echo "Experiment for Object node 1 done. Press enter to continue to next step"; read -s
./break2.sh
./run_checks.sh download_file.yml
echo "Object node 2 crashed, file downloaded. Press enter to continue to next step"; read -s
./heal2.sh
./run_checks.sh download_file.yml
echo "Object node 2 restarted, file downloaded. It still may take a while until the cluster has reconnected and is fully responsive."


echo "Experiment for Object node 2 done. Press enter to continue to next step"; read -s
./breakBoth.sh
./run_checks.sh download_file_fails.yml
echo "Both object nodes crashed, file downloaded. Press enter to continue to next step"; read -s
./healBoth.sh
./run_checks.sh download_file.yml
echo "Both Object nodes restarted, file downloaded. It still may take a while until the cluster has reconnected and is fully responsive."

echo "Cleaning up"
./cleanup.sh