source "$variables"
#TODO: improve formatting

echo "############### Running checks ###############"

echo "  ##  pinging object1  ##  "
ping -c2 object1 2>&1 || echo "unable to ping"
echo


echo "  ##  pinging object2  ##  "
ping -c2 object2 2>&1 || echo "unable to ping"
echo

echo "  ##  downloading created file  ##  "
ansible-playbook $2
echo



