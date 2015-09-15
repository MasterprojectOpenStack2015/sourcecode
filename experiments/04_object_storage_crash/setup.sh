echo "################## SETUP ###########################"
echo "$1"
source "$1"

ansible-playbook upload_file.yml
