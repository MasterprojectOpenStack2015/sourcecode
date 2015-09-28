heading SETUP

source "$variables"

subheading Checking services


services="`ssh ubuntu@controller 'source admin-openrc.sh && nova service-list || echo down'`"
log -vvv "$services"
if echo "$services" | grep -q down
then
  log -v -vv "$services"
  log -v -vv -vvv "ERROR: An OpenStack service is down. This experiment may fail in unexpected ways. (Press Ctrl+C to exit.)"
  ask_user_to_step || exit 1
fi

subheading Creating instance on controller

exitcode=0
cat setup_on_controller.sh | { ssh ubuntu@controller 2>&1 || exitcode=$? ; } | tee "$TMP_PATH/remote.log" | log -vvv --input
if ! ( exit $exitcode )
then
  echo "ERROR $exitcode in ssh."
  exit $exitcode
fi

FLOATING_IP=`tail -n1 "$TMP_PATH/remote.log" | cut -s -d ":" -f2`
echo "FLOATING_IP=$FLOATING_IP" >> "$variables"

subheading "wait for instance to come up"
until [ "`ssh-keyscan -H $FLOATING_IP 2> /dev/null`" != "" ]
do
	sleep 1
done


