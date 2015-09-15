echo "################## CREATING FAULT ################"
echo

echo "killing both Storage Nodes"
virsh destroy object1
virsh destroy object2
