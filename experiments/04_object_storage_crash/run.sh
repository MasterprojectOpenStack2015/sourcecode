#!/bin/bash

source `dirname $0`/../common/run-src.sh

#TODO: echo a description, wait for user confirmation?

experiment_heading "Crash Objct Storage"

start_stepping

step ./setup.sh
step ./run_checks.sh


step ask_user_to_step "File uploaded and downloaded."
step ./break.sh object1
step ./run_checks.sh
step ask_user_to_step "Object node 1 crashed, file downloaded."
step ./heal.sh object1
step ./run_checks.sh
step log -vv -vvv "Object node 1 restarted, file downloaded. It still may take a while until the cluster has reconnected and is fully responsive."
step ask_user_to_step "Experiment for Object node 1 done."


step ./break.sh object2
step ./run_checks.sh
step ask_user_to_step "Object node 2 crashed, file downloaded."
step ./heal.sh object2
step ./run_checks.sh
step log -vv -vvvecho "Object node 2 restarted, file downloaded. It still may take a while until the cluster has reconnected and is fully responsive."
step ask_user_to_step "Experiment for Object node 2 done."


step ./break.sh object1 object2
step ./run_checks.sh --fail
step ask_user_to_step "Both object nodes crashed, file downloaded."
step ./heal.sh object1 object2
step ./run_checks.sh 
step log -vv -vvvecho "Both Object nodes restarted, file downloaded. It still may take a while until the cluster has reconnected and is fully responsive."

./cleanup.sh