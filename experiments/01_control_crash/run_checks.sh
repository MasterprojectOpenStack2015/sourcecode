source "$variables"
#TODO: improve formatting

heading Running checks


subheading pinging the created instance
ping_check $FLOATING_IP

log -vvv

subheading pinging the controller
ping_check controller

log -vvv
