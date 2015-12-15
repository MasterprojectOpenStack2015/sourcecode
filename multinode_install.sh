sudo apt-get update
sudo apt-get install software-properties-common
sudo apt-add-repository -y ppa:ansible/ansible
sudo apt-get update
sudo apt-get install -y ansible
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ansible-playbook $DIR/multinode_installation/playbooks/install_packages_local.yml --ask-sudo-pass || exit 1
cd $DIR/multinode_installation
sudo vagrant plugin install vagrant-libvirt || exit 1
