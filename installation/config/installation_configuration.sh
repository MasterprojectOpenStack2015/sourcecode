#!/bin/sh
#
# This is the configuration script for the installation.
# Do not use variable values that stretch over more than one line.
#

###############################################################################
###### network configuration

# IP Addresses
#warning, something other than /24 doesn't actually work, fixing 2 blocks below should suffice to enable it
ip_management_prefix=192.168.100
ip_tunnel_prefix=192.168.101 
ip_external_prefix=192.168.102
ip_demo_prefix=192.168.200
network_cidr_suffix="/24"

ip_controller_suffix=11
ip_network_suffix=21
ip_compute1_suffix=31
ip_compute2_suffix=32
ip_object1_suffix=51
ip_object2_suffix=52
ip_aptcache_suffix=111

controller_node_ip_address=$ip_management_prefix.$ip_controller_suffix
network_node_ip_address=$ip_management_prefix.$ip_network_suffix
compute1_node_ip_address=$ip_management_prefix.$ip_compute1_suffix
compute2_node_ip_address=$ip_management_prefix.$ip_compute2_suffix
object1_node_ip_address=$ip_management_prefix.$ip_object1_suffix
object2_node_ip_address=$ip_management_prefix.$ip_object2_suffix
aptcache_node_ip_address=$ip_management_prefix.$ip_aptcache_suffix

external_network_cidr=$ip_external_prefix.0$network_cidr_suffix
external_network_gateway=$ip_external_prefix.1
floating_ip_start=$ip_external_prefix.101
floating_ip_end=$ip_external_prefix.200
# tenant_router_gateway_external_ip_address is the external ip address of the
# tenant router that can be acccessed from localhost
# http://docs.openstack.org/kilo/install-guide/install/apt/content/neutron_initial-networks-verify.html
tenant_router_gateway_external_ip_address=$floating_ip_start

tenant_network_cidr=$ip_demo_prefix.0$network_cidr_suffix
tenant_network_gateway=$ip_demo_prefix.1

test_node_ip_address=$controller_node_ip_address

# hostnames (e.g. for adding more nodes)
controller_node_hostname=controller
network_node_hostname=network
compute1_node_hostname=compute1
compute2_node_hostname=compute2
object1_node_hostname=object1
object2_node_hostname=object2
aptcache_node_hostname=aptcache

# network interfaces:
network_node_external_interface_name=eth2

###############################################################################
###### passwords
#
# For which passwords are required, see 
#   http://docs.openstack.org/kilo/install-guide/install/apt/content/ch_basic_environment.html#basics-networking
#

# The default_password variable should never be used directly in a script.
# default_password is the variable that can be changed to change all passwords 
# at once if they are set to default_password.
default_password=aXp7s50

# mysql_login_password is the password used for the mysql installation and service.
mysql_login_password=mysql_login_password_$default_password

# mysql_login_user is the user with the password mysql_login_password who has
# unlimited access to the database.
# If you want to log in to mysql with ansible you need to add the following 
# lines in the ansible playbook: 
#  - mysql_user: login_user={{ config.mysql_login_user }}
#                login_password={{ config.mysql_login_password }}
mysql_login_user=root

# rabbitmq_password is the password used for the rabbit message queue.
# see http://docs.openstack.org/kilo/install-guide/install/apt/content/ch_basic_environment.html#basics-message-queue
rabbitmq_password=rabbitmq_password_$default_password

# keystone_mysql_password
# see http://docs.openstack.org/kilo/install-guide/install/apt/content/keystone-install.html
keystone_mysql_password=keystone_mysql_password_$default_password

# keystone_admin_token 
# see http://docs.openstack.org/kilo/install-guide/install/apt/content/keystone-install.html
# generated by "openssl rand -hex 10"
keystone_admin_token=aec9d3a0ebc52d1fedc7 

# keystone_database_password
# see http://docs.openstack.org/kilo/install-guide/install/apt/content/keystone-install.html
keystone_database_password=$keystone_mysql_password

# keystone_os_token
# see http://docs.openstack.org/kilo/install-guide/install/apt/content/keystone-services.html
# OS_TOKEN=ADMIN_TOKEN
keystone_os_token=$keystone_admin_token

# openstack_admin_user_password
# see http://docs.openstack.org/kilo/install-guide/install/apt/content/keystone-users.html
# this is the password for the openstack user 'admin'
openstack_admin_user_password=admin

# openstack_demo_user_password
# see http://docs.openstack.org/kilo/install-guide/install/apt/content/keystone-users.html
# this is the password for the openstack user 'demo'
openstack_demo_user_password=demo

# glance_mysql_password
# http://docs.openstack.org/kilo/install-guide/install/apt/content/glance-install.html
glance_mysql_password=glance_mysql_password_$default_password

# glance_user_password
# http://docs.openstack.org/kilo/install-guide/install/apt/content/glance-install.html
glance_user_password=glance_user_password_$default_password

# nova_mysql_password
# http://docs.openstack.org/kilo/install-guide/install/apt/content/ch_nova.html#compute-service
nova_mysql_password=nova_mysql_password_$default_password

# nova_user_password
# http://docs.openstack.org/kilo/install-guide/install/apt/content/ch_nova.html#compute-service
nova_user_password=nova_user_password_$default_password


# neutron_mysql_password
# http://docs.openstack.org/kilo/install-guide/install/apt/content/neutron-controller-node.html
neutron_mysql_password=neutron_mysql_password_$default_password

# neutron_user_password
# http://docs.openstack.org/kilo/install-guide/install/apt/content/neutron-controller-node.html
neutron_user_password=neutron_user_password_$default_password

# metadata_proxy_shared_secret
# http://docs.openstack.org/kilo/install-guide/install/apt/content/neutron-network-node.html
metadata_proxy_shared_secret=metadata_proxy_shared_secret_$default_password


# swift_user_password
# http://docs.openstack.org/kilo/install-guide/install/apt/content/swift-install-controller-node.html
swift_user_password=swift_user_password_$default_password

# swift_hash_path
# http://docs.openstack.org/kilo/install-guide/install/apt/content/swift-finalize-installation.html
swift_hash_path_suffix=suffix_$default_password
swift_hash_path_prefix=prefix_$default_password

###############################################################################
###### configuration for keystone

# os_auth_..._url is the url that authentication goes towards
# see http://docs.openstack.org/kilo/install-guide/install/apt/content/keystone-verify.html
# openstack --os-auth-url "$os_auth_admin_url"
os_auth_admin_url=http://${controller_node_hostname}:35357
os_auth_user_url=http://${controller_node_hostname}:5000

# keystone_os_url
# see http://docs.openstack.org/kilo/install-guide/install/apt/content/keystone-services.html
# OS_URL=http://controller:35357/v2.0
# For the port 35357 see "wsgi-keystone.conf".
# This is the admin interface url for the identity service
keystone_os_url=${os_auth_admin_url}/v2.0

# In step 3.04 of http://docs.openstack.org/kilo/install-guide/install/apt/content/keystone-services.html
# we create the identity service and configure the http ports for access
# OpenStack uses three API endpoint variants for each service: admin, internal, and public. The admin API endpoint allows modifying users and tenants by default, while the public and internal APIs do not. In a production environment, the variants might reside on separate networks that service different types of users for security reasons. For instance, the public API network might be reachable from outside the cloud for management tools, the admin API network might be protected, while the internal API network is connected to each host. Also, OpenStack supports multiple regions for scalability. For simplicity, this guide uses the management network for all endpoint variations and the default RegionOne region.
identity_admin_url=$keystone_os_url
identity_public_url=${os_auth_user_url}/v2.0
identity_internal_url=$identity_public_url


###############################################################################
###### configuration for glance

# glance_os_url
# see http://docs.openstack.org/kilo/install-guide/install/apt/content/glance-install.html
glance_os_url=http://${controller_node_hostname}:9292

# default_image_url is the url of the default image that is uploaded during 
# the setup.
default_image_url=http://download.cirros-cloud.net/0.3.4/cirros-0.3.4-x86_64-disk.img

# default_image_name is the display name of the default image 
# from default_image_url
default_image_name=cirros-0.3.4-x86_64

###############################################################################
###### configuration for swift and object storage nodes

# partition names that occus in /dev/
object_partition_1_name=vdc
object_partition_2_name=vdd


###############################################################################
###### configuration for download

# downloads_directory is the directory where to download the image files to
downloads_directory='/tmp/openstack_installation/downloads'

# vm_image_url is the url for the image in the vms.
# When you change this also change vm_image_md5_hash and 
#   maybe also remote_user in ansible.cfg.
# I had a look at https://cloud-images.ubuntu.com/trusty/ for the url.
# For the current release you can use 'https://cloud-images.ubuntu.com/trusty/current/trusty-server-cloudimg-amd64-disk1.img'
vm_image_url='https://cloud-images.ubuntu.com/trusty/current/trusty-server-cloudimg-amd64-disk1.img'

# vm_image_md5_hash is the md5 hash of the vm image.
# It is used to avoid duplicate downloads.
# If this hash does not fit, the image will be downloaded
# every time the vms are set up.
# If the hash is empty there will be no check. When you interrupt the download
# you may need to delete $downloads_directory manually.
# is ba8c94999ca0d5052ccc0d4b12b9aca4 for 'https://cloud-images.ubuntu.com/trusty/20150313/trusty-server-cloudimg-amd64-disk1.img'
vm_image_md5_hash=

# downloaded_vm_image_folder is the folder where the downloaded vm image is 
# saved.
downloaded_vm_image_folder=$downloads_directory/images/vm


# apt_cache_dir is where packages requested by the VMs are cached by
# the aptcache node

apt_cache_dir="/tmp/openstack_apt_cache_dir"
###############################################################################
###### configuration for the creation of the vms

# vm_images_directory is the folder where the image files of the virtual
# machines are stored.
# If you change this path be aware that the paths in the xml files in config/vm 
# need to be changed as well.
vm_images_directory='/tmp/openstack_installation/images'

# vm_base_image_name is the name of the downloaded image.
vm_base_image_name='vm.img'

# user_data_cloud_config_file is the configuration file used by could-init.
# See "Create a user-data file" in http://serverascode.com/2014/03/17/trusty-libvirt.html
# There we specify that the password and ssh key are set on the vm.
user_data_cloud_config_file='user-data.cloud-config'
user_data_cloud_config_image='user-data.cloud-config.img'
user_data_cloud_config_image_qcow='user-data.cloud-config.qcow'

# authorized_public_key_file_for_access_to_the_vm is the public key that allows
# us to access the vm once it is started.
authorized_public_key_file_for_access_to_the_vm=~/.ssh/id_rsa.pub
authorized_private_key_file_for_access_to_the_vm=~/.ssh/id_rsa

# authorized_password_for_access_to_the_vm is the password that allows us to 
# access the vm once it is started. If the password is empty you can not log in
# with a password. Also see the ansible.cfg file. It contains a "remote_user" 
# variable that sets the ansible remote user.
authorized_password_for_access_to_the_vm=

###############################################################################
###### ansible configuration

# ansible_temp_directory is the directory where we store temporary ansible 
# files.
ansible_temp_directory='/tmp/openstack_installation/ansible'

# generated_ansible_roles_directory is the directory where we generate the 
# config role. This role contains all variables defined in this configuration 
# file. Variables can be used in ansible like this: 
#   {{ config.generated_ansible_roles_directory }}
# Do not use spaces in this variable. 
generated_ansible_roles_directory=/etc/ansible/roles

# configuration_directory is the directory of the config files
# from http://stackoverflow.com/a/246128
configuration_directory=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
configuration_directory=`realpath $configuration_directory`

# installation_directory is the directory in which install.sh is placed
installation_directory=`realpath "$configuration_directory"/..`

# tools is the directory of the tools files.
tools=$installation_directory/tools

# ansible_configuration_directory is the directory of the ansible configuration
ansible_configuration_directory=$configuration_directory/ansible

# ansible_playbooks_directory is the directory of all the playbook files 
ansible_playbooks_directory=$installation_directory/playbooks

###############################################################################
###### setup to make variables valid

# create the downloads directory
mkdir -p $downloads_directory
mkdir -p $vm_images_directory
mkdir -p $ansible_temp_directory
vm_base_image_file=$vm_images_directory/$vm_base_image_name

ANSIBLE_CONFIG=`realpath $ansible_configuration_directory/ansible.cfg`
