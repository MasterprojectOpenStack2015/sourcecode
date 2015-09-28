source demo-openrc.sh

INSTANCE_NAME=experiment-01-test-instance

# kill an instance if it exists
echo Killing the instance $INSTANCE_NAME
nova force-delete $INSTANCE_NAME

#TODO: supress/shorten outputs where helpful


#TODO: don't do this if already there
nova keypair-add experiment-key

#get net id of "default" network
DEFAULT_NETWORK_ID=`neutron net-show demo-net | grep "|\sid" | cut -s -d "|" -f3 | tr -d '[[:space:]]'`

#create instance
echo "creating instance as demo user..."
echo nova boot --flavor m1.tiny --image cirros-0.3.4-x86_64 --nic net-id=$DEFAULT_NETWORK_ID --security-group default --key-name experiment-key $INSTANCE_NAME
nova boot --flavor m1.tiny --image cirros-0.3.4-x86_64 --nic net-id=$DEFAULT_NETWORK_ID --security-group default --key-name experiment-key $INSTANCE_NAME > 01_crash_conroller.out 
exit_code=$?
cat 01_crash_conroller.out
if !( exit $exit_code )
then
  exit $exit_code
fi

instance_id=`cat 01_crash_conroller.out | grep "|\s*id" | cut -s -d "|" -f3 | tr -d '[[:space:]]'`

echo instance id: $instance_id

#create & assign floating IP
echo "creating floating IP"
FLOATING_IP=`neutron floatingip-create ext-net | grep '| floating_ip_address' | cut -s -d '|' -f3 | tr -d '[[:space:]]'`
echo "associating floating ip $FLOATING_IP"
nova floating-ip-associate $instance_id $FLOATING_IP || exit 2

echo "FLOATING_IP:$FLOATING_IP"
