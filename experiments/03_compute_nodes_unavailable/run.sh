# use the log command
PATH=`dirname "$0"`/../common:`dirname "$0"`/../../installaion/tools:$PATH

# crate variables file to allow the scripts to change the variables
TMP_PATH=/tmp/openstack_experiments/03_compute_nodes_unavailable
mkdir -p $TMP_PATH
echo "TMP_PATH=\"$TMP_PATH\"" > "$TMP_PATH/variables.tmp"
export variables="$TMP_PATH/variables.tmp"

experiment_heading "Crash Output"



start_stepping

step ./setup.sh
step ./run_checks.sh
step ask_user_to_step

step ./break_1.sh
step run_repeated ./run_checks.sh

step ./break_2.sh
step run_repeated ./run_checks.sh

step ./heal.sh
step run_repeated ./run_checks.sh
