TMP_PATH=/tmp/openstack_experiments/01_control_crash
mkdir -p $TMP_PATH
echo "TMP_PATH=\"$TMP_PATH\"" > "$TMP_PATH/variables.tmp"

#TODO: echo a description, wait for user confirmation?

./setup.sh "$TMP_PATH/variables.tmp"
./run_checks.sh "$TMP_PATH/variables.tmp"
./break.sh "$TMP_PATH/variables.tmp"
./run_checks.sh "$TMP_PATH/variables.tmp"
./heal.sh "$TMP_PATH/variables.tmp"
./run_checks.sh "$TMP_PATH/variables.tmp"


