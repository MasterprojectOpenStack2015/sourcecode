source "$1"

echo "flushing memcache on controller"
ssh ubuntu@controller "echo flush_all | nc localhost 11211"


