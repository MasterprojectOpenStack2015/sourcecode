source "$variables"

subheading shut down all compute hosts

virsh list --name | grep  -E "compute[0-9]+" > "$TMP_PATH/compute_VMs.log"
for VM in `cat "$TMP_PATH/compute_VMs.log"`
do
	virsh shutdown $VM | grep -v '^$'
done

log -v -vv -vvv "All compute nodes have been shut down"
