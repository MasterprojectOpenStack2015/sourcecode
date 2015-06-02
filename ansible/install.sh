#!/bin/sh

#ip of nodes (network must be setup as described here: http://docs.openstack.org/kilo/install-guide/install/apt/content/ch_basic_environment.html):
USER="vm"
controller_node="$USER@192.168.100.11"
network_node="$USER@192.168.100.21"
compute_node1="$USER@192.168.100.31"
#TODO: list of nodes, to be looped over

#install ansible:
echo "Installing ansible..."
sudo apt-add-repository -y ppa:ansible/ansible &>/dev/null
sudo apt-get -qq -y update &>/dev/null

PACKAGES="software-properties-common ansible"
for pkg in $PACKAGES; do
if dpkg --get-selections | grep -q "^$pkg[[:space:]]*install$" >/dev/null; then
    echo "$pkg is already installed"
else
    if sudo apt-get -qq -y install $pkg; then
	    echo "Successfully installed $pkg"
	else
	    echo "Error installing $pkg"
	fi
fi
done
echo "Installation Done."

#ask for sudo PW on machines:
sudo sed -i 's/#ask_sudo_pass/ask_sudo_pass/g' ansible.cfg

#public/private key setup:
mkdir ~/.ssh &>/dev/null

if [ ! -f ~/.ssh/id_rsa ] 
then
	ssh-keygen -t rsa -f ~/.ssh/id_rsa -N ""
fi

cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys

ssh-copy-id -i ~/.ssh/id_rsa.pub $controller_node
ssh-copy-id -i ~/.ssh/id_rsa.pub $network_node
ssh-copy-id -i ~/.ssh/id_rsa.pub $compute_node1



echo "\n\n[controller]\n\t$controller_node" | sudo tee /etc/ansible/hosts
echo "\n\n[network]\n\t$network_node" | sudo tee -a /etc/ansible/hosts
echo "\n\n[compute]\n\t$compute_node1" | sudo tee -a /etc/ansible/hosts

echo "Testing Network Configuration..."
#ansible controller -a "ping -c 4 openstack.org"
#ansible controller -a "ping -c 4 compute1"
#ansible compute -a "ping -c 4 openstack.org"
#ansible compute -a "ping -c 4 controller"

#TODO for real distribution: configure NTP on the nodes

echo "Installing OpenStack..."
ansible all -b --ask-become-pass -m apt -a 'pkg=ubuntu-cloud-keyring state=installed update_cache=yes'
ansible all -a "echo \"deb http://ubuntu-cloud.archive.canonical.com/ubuntu\" \"trusty-updates/kilo main\" > /etc/apt/sources.list.d/cloudarchive-kilo.list"
ansible all -b --ask-become-pass -m apt -a 'update_cache=yes'
ansible all -b --ask-become-pass -m apt -a 'upgrade=dist'
echo "Installation Done."


echo "Installing MySql..."
ansible controller -b --ask-become-pass -m apt -a 'pkg=mariadb-server state=installed update_cache=yes'
ansible controller -b --ask-become-pass -m apt -a 'pkg=python-mysqldb state=installed update_cache=yes'
echo "Installation Done."
