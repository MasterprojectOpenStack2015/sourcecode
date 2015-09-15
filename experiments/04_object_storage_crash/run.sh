TMP_PATH=/tmp/openstack_experiments/04_object_storage_crash
mkdir -p $TMP_PATH
echo "TMP_PATH=\"$TMP_PATH\"" > "$TMP_PATH/variables.tmp"

#TODO: echo a description, wait for user confirmation?

./setup.sh "$TMP_PATH/variables.tmp"
./run_checks.sh "$TMP_PATH/variables.tmp"


echo "File uploaded and downloaded. Press enter to continue to next step"; read -s
./break1.sh "$TMP_PATH/variables.tmp"
./run_checks.sh "$TMP_PATH/variables.tmp"
echo "Object node 1 crashed, file downloaded. Press enter to continue to next step"; read -s
./heal1.sh "$TMP_PATH/variables.tmp"
./run_checks.sh "$TMP_PATH/variables.tmp"
echo "Object node 1 restarted, file downloaded. It still may take a while until the cluster has reconnected and is fully responsive."


echo "Experiment for Object node 1 done. Press enter to continue to next step"; read -s
./break2.sh "$TMP_PATH/variables.tmp"
./run_checks.sh "$TMP_PATH/variables.tmp"
echo "Object node 2 crashed, file downloaded. Press enter to continue to next step"; read -s
./heal2.sh "$TMP_PATH/variables.tmp"
./run_checks.sh "$TMP_PATH/variables.tmp"
echo "Object node 2 restarted, file downloaded. It still may take a while until the cluster has reconnected and is fully responsive."


echo "Experiment for Object node 2 done. Press enter to continue to next step"; read -s
./breakBoth.sh "$TMP_PATH/variables.tmp"
./run_checks.sh "$TMP_PATH/variables.tmp"
echo "Both object nodes crashed, file downloaded. Press enter to continue to next step"; read -s
./healBoth.sh "$TMP_PATH/variables.tmp"
./run_checks.sh "$TMP_PATH/variables.tmp"
echo "Both Object nodes restarted, file downloaded. It still may take a while until the cluster has reconnected and is fully responsive."

echo "Cleaning up"
./cleanup.sh