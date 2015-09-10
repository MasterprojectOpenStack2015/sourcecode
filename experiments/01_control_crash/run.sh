TMP_PATH=/tmp/openstack_experiments/01_control_crash
mkdir -p $TMP_PATH
echo "TMP_PATH=\"$TMP_PATH\"" > "$TMP_PATH/variables.tmp"

#TODO: echo a description, wait for user confirmation?

./setup.sh "$TMP_PATH/variables.tmp"
./run_checks.sh "$TMP_PATH/variables.tmp"


echo "Press enter to continue to next step"; read -s
./break.sh "$TMP_PATH/variables.tmp"
./run_checks.sh "$TMP_PATH/variables.tmp"
echo "Press enter to continue to next step"; read -s
./heal.sh "$TMP_PATH/variables.tmp"
./run_checks.sh "$TMP_PATH/variables.tmp"
echo "It still may take a while until the cluster has reconnected and is fully responsive."


