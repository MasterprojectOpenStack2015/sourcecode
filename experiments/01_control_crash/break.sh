heading CREATING FAULT

subheading killing the controller
virsh shutdown controller 2>&1 | log -vvv --input 

subheading waiting for the controller to shut down

while list_domains | grep -q controller
do
	sleep 1
	log -vvv -n .
done