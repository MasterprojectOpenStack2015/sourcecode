source "$variables"
subheading "restarting compute nodes"

for VM in `cat "$TMP_PATH/compute_VMs.log"`
do
	virsh start $VM | grep -v '^$'
done

subheading "wait for nodes to come up again"
for VM in `cat "$TMP_PATH/compute_VMs.log"`
do
	until [ "`ssh-keyscan -H $VM 2> /dev/null`" != "" ]
	do
		sleep 1
		log -vvv -n .
	done
done

subheading "waiting a bit"
sleep 10
