source "$variables"

subheading kill network connections off all compute hosts

for compute_host in `ansible compute --list-hosts`
do
	#shutdown management-network interface
	ssh -n -f ubuntu@$compute_host "nohup sudo ifdown \`ip route | grep $compute_host | cut -d' ' -f3\` > /dev/null 2>&1 &"
done

log -v -vv -vvv "All compute hosts have been incapacitated"
