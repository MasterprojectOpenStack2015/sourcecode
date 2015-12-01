sudo apt-add-repository -y ppa:ansible/ansible
sudo apt-get -y update
sudo apt-get -y install software-properties-common ansible
ansible-playbook multinode_installation/playbooks/install_packages_local.yml --ask-sudo-pass || exit 1
