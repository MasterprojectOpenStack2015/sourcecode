TMP_PATH=/tmp/openstack_experiments/02_memcache_flush
mkdir -p $TMP_PATH
echo "TMP_PATH=\"$TMP_PATH\"" > "$TMP_PATH/variables.tmp"

#TODO: echo a description, wait for user confirmation?
#TODO: echo prompt for user to look at horizon?! (but that caches somehow internally and isn't clearly visible)



./setup.sh "$TMP_PATH/variables.tmp"
./run_checks.sh "$TMP_PATH/variables.tmp"
echo "Press enter to continue to next step"; read -s
./break.sh "$TMP_PATH/variables.tmp"
./run_checks.sh "$TMP_PATH/variables.tmp"

