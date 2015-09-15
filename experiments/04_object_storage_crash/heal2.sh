echo "################## HEALING FAULT #################"
echo

echo "restarting Storage Node 2"
virsh start object2

echo "wait for object2 to come up again"
until [ "`ssh-keyscan -H object1 2> /dev/null`" != "" ]
do
	sleep 1
done

