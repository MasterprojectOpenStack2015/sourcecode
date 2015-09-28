source "$variables"
#TODO: improve formatting

heading Running checks


subheading pinging the created instance
ping -c1 $FLOATING_IP 2>&1 | head -n2 | log -vvv -i

log -vvv

subheading pinging the controller
ping -c1 controller 2>&1 | head -n2 | log -vvv -i

log -vvv
