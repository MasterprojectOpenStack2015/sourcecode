#!/bin/bash

source `dirname $0`/../common/run-src.sh

experiment_heading "Compute Node Availability"

start_stepping

step ./heal.sh
step ./setup.sh
step ./run_checks.sh
step ask_user_to_step

step ./break_1.sh
step run_repeated ./run_checks.sh

step ./break_2.sh
step run_repeated ./run_checks.sh

step ./heal.sh
step run_repeated ./run_checks.sh
