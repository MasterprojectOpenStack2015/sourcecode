source "$1"

echo "shutting down compute nodes"

virsh list --name | grep  -E "compute[0-9]+" > "$TMP_PATH/compute_VMs.log"
for VM in `cat "$TMP_PATH/compute_VMs.log"`
do
	virsh shutdown $VM | grep -v '^$'
done

