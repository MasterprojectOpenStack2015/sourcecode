
source ../common/run-src.sh

#TODO: echo a description, wait for user confirmation?
#TODO: echo prompt for user to look at horizon?! (but that caches somehow internally and isn't clearly visible)

start_stepping 

step ./setup.sh
step ./run_checks.sh

ask_user_to_step

step ./break.sh
step ./run_checks.sh

