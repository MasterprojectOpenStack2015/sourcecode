source demo-openrc.sh

#TODO: supress/shorten outputs where helpful


#TODO: don't do this if already there
nova keypair-add experiment-key

#get net id of "default" network
DEFAULT_NETWORK_ID=`neutron net-show demo-net | grep "| id" | cut -s -d "|" -f3 | tr -d '[[:space:]]'`

#create instance
echo "creating instance as demo user..."
echo nova boot --flavor m1.tiny --image cirros-0.3.4-x86_64 --nic net-id=$DEFAULT_NETWORK_ID --security-group default --key-name experiment-key experiment-01-test-instance
nova boot --flavor m1.tiny --image cirros-0.3.4-x86_64 --nic net-id=$DEFAULT_NETWORK_ID --security-group default --key-name experiment-key experiment-01-test-instance > /dev/null

#create & assign floating IP
FLOATING_IP=`neutron floatingip-create ext-net | grep '| floating_ip_address' | cut -s -d '|' -f3 | tr -d '[[:space:]]'`
nova floating-ip-associate experiment-01-test-instance $FLOATING_IP

echo "FLOATING_IP:$FLOATING_IP"
