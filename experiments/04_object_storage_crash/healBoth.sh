echo "################## HEALING FAULT #################"
echo

echo "restarting the Storage Nodes"
virsh start object1
virsh start object2

echo "wait for object1 to come up again"
until [ "`ssh-keyscan -H object1 2> /dev/null`" != "" ]
do
	sleep 1
done

echo "wait for object2 to come up again"
until [ "`ssh-keyscan -H object2 2> /dev/null`" != "" ]
do
	sleep 1
done
