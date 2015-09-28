
# use the log command
source `dirname $0`/../common/run-src.sh

experiment_heading "Crash Output"
#TODO: echo a description, wait for user confirmation?
#TODO: add stages of severity?

start_stepping 

step ./setup.sh
step ./run_checks.sh

step ask_user_to_step
step ./break.sh
step ./run_checks.sh

step ask_user_to_step
step ./heal.sh
step ./run_checks.sh

step ./warn.sh



