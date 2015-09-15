source "$1"
#TODO: improve formatting

echo "############### Running checks ###############"

echo "  ##  pinging object1  ##  "
ping -c2 object1 2>&1 | head -n2
echo


echo "  ##  pinging object2  ##  "
ping -c2 object2 2>&1 | head -n2
echo

echo "  ##  downloading created file  ##  "
ansible-playbook download_file.yml
echo



