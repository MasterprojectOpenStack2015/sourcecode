#!/bin/sh

#ip of nodes (network must be setup as described here: http://docs.openstack.org/kilo/install-guide/install/apt/content/ch_basic_environment.html):
controller_node = 192.168.100.11
network_node = 192.168.100.21
compute_node1 = 192.168.100.31


#install ansible:
sudo apt-get -y install software-properties-common
sudo apt-add-repository -y ppa:ansible/ansible
sudo apt-get -y update
sudo apt-get -y install ansible

#public/private key setup:
mkdir ~/.ssh

if [ ! -f ~/.ssh/id_rsa ] 
then
	ssh-keygen -t rsa -f ~/.ssh/id_rsa -N ""
fi

cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys

# test on localhost:
echo "[local]\n\tlocalhost" | sudo tee /etc/ansible/hosts

ansible local -m ping

echo "\n\n[controller]\n\t$controller_node" | sudo tee -a /etc/ansible/hosts
echo "\n\n[network]\n\t$network_node" | sudo tee -a /etc/ansible/hosts
echo "\n\n[compute]\n\t$compute_node1" | sudo tee -a /etc/ansible/hosts

