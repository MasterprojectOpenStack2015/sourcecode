#!/bin/bash

source config/installation_configuration.sh

# There are a lot of tests in this file. 
# They are used to remove unnecessary sudo commands.

# configure the ansible hosts file
tools/config_variables | tools/render_template $ansible_configuration_directory/hosts > $ansible_temp_directory/hosts

     # cmp - compare files
     #   http://stackoverflow.com/questions/12900538/unix-fastest-way-to-tell-if-two-files-are-the-same
if ! cmp --silent /etc/ansible/hosts $ansible_temp_directory/hosts
then
	# copy ansible hosts file to /etc/ansible/
	sudo rm -f /etc/ansible/hosts
	# sudo and piping into files http://stackoverflow.com/a/82278/1320237
	sudo mv $ansible_temp_directory/hosts /etc/ansible/hosts
fi

# copy ansible config file to /etc/ansible/
if ! cmp --silent /etc/ansible/ansible.cfg $ansible_configuration_directory/ansible.cfg
then
	sudo rm -f /etc/ansible/ansible.cfg 
	sudo ln -s `realpath $ansible_configuration_directory/ansible.cfg` /etc/ansible/ansible.cfg
fi

# create an .yml file for the configuration
roles_variables_directory=$generated_ansible_roles_directory/config/vars
variables_file=$roles_variables_directory/main.yml
temp_variables_file=$ansible_temp_directory/roles_config_vars_main.yml

echo '---
config:' > $temp_variables_file
# for a valid variable example read http://stackoverflow.com/a/26640550/1320237
tools/config_variables | sed 's/^\([^=]*\)=/  \1: /g' >> $temp_variables_file

# create token, admin and, demo environment
echo "
  environment:
    token:
      OS_TOKEN: \"$keystone_os_token\"
      OS_URL:   \"$keystone_os_url\"
    admin:
      # see ~/admin-openrc.sh or $ansible_playbooks_directory/03_Add_the_Identity_service/admin-openrc.sh.j2
      OS_PROJECT_DOMAIN_ID: default
      OS_USER_DOMAIN_ID:    default
      OS_PROJECT_NAME:      admin
      OS_TENANT_NAME:       admin
      OS_USERNAME:          admin
      OS_PASSWORD:          \"$openstack_admin_user_password\"
      OS_AUTH_URL:          \"${os_auth_admin_url}/v3\"
      # from http://docs.openstack.org/kilo/install-guide/install/apt/content/glance-verify.html
      OS_IMAGE_API_VERSION: 2
    demo:
      # see ~/demo-openrc.sh or $ansible_playbooks_directory/03_Add_the_Identity_service/demo-openrc.sh.j2
      OS_PROJECT_DOMAIN_ID: default
      OS_USER_DOMAIN_ID:    default
      OS_PROJECT_NAME:      demo
      OS_TENANT_NAME:       demo
      OS_USERNAME:          demo
      OS_PASSWORD:          \"$openstack_demo_user_password\"
      OS_AUTH_URL:          \"${os_auth_user_url}/v3\"
      # from http://docs.openstack.org/kilo/install-guide/install/apt/content/glance-verify.html
      OS_IMAGE_API_VERSION: 2" >> $temp_variables_file

if [[ ! -f $variables_file ]] || ! cmp --silent $temp_variables_file $variables_file
then
	sudo mkdir -p $roles_variables_directory
	sudo rm -f $variables_file
	sudo mv $temp_variables_file $variables_file
fi 
