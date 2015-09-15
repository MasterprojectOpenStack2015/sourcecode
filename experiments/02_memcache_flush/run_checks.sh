source "$1"

echo "############### Running checks ###############"

echo "### attempting to create new token using first token ###"
echo "(full response written to $TMP_PATH/check_curl.log)"
curl -s -S -i \
  -H "Content-Type: application/json" \
  -d '
{ "auth": {
    "identity": {
      "methods": ["token"],
      "token": {
        "id": "'$TOKEN'"
      }
    }
  }
}' http://controller:5000/v3/auth/tokens > "$TMP_PATH/check_curl.log"

if grep -q "HTTP/1.1 201 Created" "$TMP_PATH/check_curl.log"
then
    echo -n "Token created: "
    grep "X-Subject-Token:" "$TMP_PATH/check_curl.log"
else
    echo -n "ERROR:"
    tail -n1 "$TMP_PATH/check_curl.log"
fi

echo
