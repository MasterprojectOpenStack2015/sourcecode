heading SETUP

source "$variables"

subheading Checking services


services="`ssh ubuntu@controller 'source admin-openrc.sh && nova service-list || echo down'`"
log -vvv "$services"
if echo "$services" | grep -q down
then
  log -v -vv "$services"
  log -v -vv -vvv 
  log -v -vv -vvv "ERROR: An OpenStack service is down. This experiment may fail in unexpected ways."
  log -v -vv -vvv "       Maybe execute 'virsh reboot HOST'?"
  ask_user_to_step "Press Ctrl+C to exit." || exit 1
fi

subheading Creating instance on controller

create_openstack_instance_named experiment-01-test-instance || exit 44

source "$variables"


subheading "wait for instance to come up"
until [ "`ssh-keyscan -H $FLOATING_IP 2> /dev/null`" != "" ]
do
	sleep 1
done


