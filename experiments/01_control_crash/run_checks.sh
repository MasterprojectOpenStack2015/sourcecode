source "$1"
#TODO: improve formatting

echo "############### Running checks ###############"


echo "  ##  pinging the created instance  ##  "
ping -c1 $FLOATING_IP 2>&1 | head -n2

echo

echo "  ##  pinging the controller  ##  "
ping -c1 controller 2>&1 | head -n2

echo

