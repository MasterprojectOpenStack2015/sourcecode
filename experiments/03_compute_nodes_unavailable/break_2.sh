heading CREATING FAULT


source "$variables"

subheading shut down all compute hosts

for VM in `cat "$TMP_PATH/compute_VMs.log"`
do
	virsh shutdown $VM 2>&1 | grep -v '^$' | log -vvv -i
done

log_ok "All compute nodes have been shut down."
