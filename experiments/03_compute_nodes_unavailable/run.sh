TMP_PATH=/tmp/openstack_experiments/03_compute_nodes_unavailable
mkdir -p $TMP_PATH
echo "TMP_PATH=\"$TMP_PATH\"" > "$TMP_PATH/variables.tmp"

./setup.sh "$TMP_PATH/variables.tmp"
./run_checks.sh "$TMP_PATH/variables.tmp"


echo "Press enter to continue to next step"; read -s
./break_1.sh "$TMP_PATH/variables.tmp"
./run_checks.sh "$TMP_PATH/variables.tmp"

echo "Press enter to continue to next step"; read -s
./break_2.sh "$TMP_PATH/variables.tmp"
./run_checks.sh "$TMP_PATH/variables.tmp"

echo "Press enter to continue to next step"; read -s
./heal.sh "$TMP_PATH/variables.tmp"
./run_checks.sh "$TMP_PATH/variables.tmp"
