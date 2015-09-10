echo "################## SETUP ###########################"
echo "$1"
source "$1"

cat setup_on_controller.sh | ssh ubuntu@controller | tee "$TMP_PATH/remote.log"

FLOATING_IP=`tail -n1 "$TMP_PATH/remote.log" | cut -s -d ":" -f2`
echo "FLOATING_IP=$FLOATING_IP" >> "$1"

echo "wait for instance to come up"
until [ "`ssh-keyscan -H $FLOATING_IP 2> /dev/null`" != "" ]
do
	sleep 1
done


