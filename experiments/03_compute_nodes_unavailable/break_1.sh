heading CREATING FAULT


source "$variables"

subheading kill network connections off all compute hosts

virsh list --name | grep  -E "compute[0-9]+" > "$TMP_PATH/compute_VMs.log"
for compute_host in `ansible compute --list-hosts`
do
	#shutdown management-network interface
	ssh -n -f ubuntu@$compute_host "nohup sudo ifdown \`ip route | grep $compute_host | cut -d' ' -f3\` > /dev/null 2>&1 &"
done

log_ok "All compute hosts have been incapacitated."
