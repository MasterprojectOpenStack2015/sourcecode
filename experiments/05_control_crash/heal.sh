heading HEALING FAULT

subheading "restarting the controller"
virsh start controller 2>&1 | log -vvv --input

subheading "wait for controller to come up again"
until [ "`ssh-keyscan -H controller 2> /dev/null`" != "" ]
do
	sleep 1
	log -vvv -n .
done

#todo: wait for compute nodes to be found
