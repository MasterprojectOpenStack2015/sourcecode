echo "################## HEALING FAULT #################"
echo

echo "restarting Storage Node 1"
virsh start object1

echo "wait for object1 to come up again"
until [ "`ssh-keyscan -H object1 2> /dev/null`" != "" ]
do
	sleep 1
done

