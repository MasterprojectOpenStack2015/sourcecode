source "$variables"

#create first VM
subheading create test instance while everything is working fine
create_openstack_instance_named experiment-03-test-instance1 || exit 44
source "$variables"
FLOATING_IP1=$FLOATING_IP
echo "FLOATING_IP1=$FLOATING_IP" >> "$variables"


subheading "wait for instance to come up"
until [ "`ssh-keyscan -H $FLOATING_IP1 2> /dev/null`" != "" ]
do
	sleep 1
done


