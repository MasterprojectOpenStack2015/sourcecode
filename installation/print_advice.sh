#!/bin/bash

source config/installation_configuration.sh

echo "To use the Horizon Web interface visit http://$controller_node_hostname/horizon/"
echo "  You may need to wait some time until the virtual machines are restarted."
echo "  Logins are "
echo "    user: \"demo\" password: \"$openstack_demo_user_password\""
echo "    user: \"admin\" password: \"$openstack_admin_user_password\""
echo "  as specified in the configuration."
echo "To use SSH execute"
for vm_name in `tools/vm_names`
do
  echo "  ssh `tools/ansible_remote_user`@$vm_name"
done

