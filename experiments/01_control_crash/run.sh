
# use the log command
PATH=`dirname "$0"`/../common:`dirname "$0"`/../../installaion/tools:$PATH

# crate variables file to allow the scripts to change the variables
TMP_PATH=/tmp/openstack_experiments/01_control_crash
mkdir -p $TMP_PATH
echo "TMP_PATH=\"$TMP_PATH\"" > "$TMP_PATH/variables.tmp"
export variables="$TMP_PATH/variables.tmp"

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

step ./warn



