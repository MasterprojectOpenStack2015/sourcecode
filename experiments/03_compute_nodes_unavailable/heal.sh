echo "restarting compute nodes"

for VM in `cat "$TMP_PATH/compute_VMs.log"`
do
	virsh start $VM | grep -v '^$'
done
