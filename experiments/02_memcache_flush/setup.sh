source "$1"

echo "on controller, get token from Keystone (as admin)"
ssh ubuntu@controller "source admin-openrc.sh; openstack token issue" | tee "$TMP_PATH/remote.log"

TOKEN=`grep " id" "$TMP_PATH/remote.log" | cut -s -d "|" -f3 |  tr -d '[[:space:]]'`
echo "TOKEN=$TOKEN" >> "$1"
