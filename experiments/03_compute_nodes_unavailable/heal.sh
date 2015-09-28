

source "$variables"

if [ ! -f $TMP_PATH/compute_VMs.log ]
then
  # nothing to heal
  exit 0
fi
heading HEALING FAULT


for VM in `cat "$TMP_PATH/compute_VMs.log"`
do
    subheading "restarting compute node $VM"
	if ! ping -c1 $VM 2>&1 > /dev/null
	then
	  virsh reboot $VM 2>&1 | grep -v '^$' | log -vvv -i
	  virsh start $VM  2>&1 | grep -v '^$' | log -vvv -i
	fi
done


for VM in `cat "$TMP_PATH/compute_VMs.log"`
do
	subheading "wait for $VM to come up again"
	until [ "`ssh-keyscan -H $VM 2> /dev/null`" != "" ]
	do
		sleep 1
		log -vvv -n .
	done
done

log -vvv 