heading SETUP

source "$variables"

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


