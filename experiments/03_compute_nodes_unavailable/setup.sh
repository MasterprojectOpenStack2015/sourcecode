source "$1"

#create first VM
#this is completely the same as in experiment01 and should be adapted from there, except for a) the different VM name and b) the different variable for the floating IP

../common/create_openstack_instance_named experiment-01-test-instance || exit 44
source "$variables"
FLOATING_IP1 = $FLOATING_IP
echo "FLOATING_IP1=$FLOATING_IP" > "$variables"


echo "wait for instance to come up"
until [ "`ssh-keyscan -H $FLOATING_IP1 2> /dev/null`" != "" ]
do
	sleep 1
done


