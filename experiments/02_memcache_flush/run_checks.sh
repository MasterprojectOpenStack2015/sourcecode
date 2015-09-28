source "$variables"

heading Running checks

subheading attempting to create new token using first token

log -vvv "(full response written to $TMP_PATH/check_curl.log)"

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

cat $TMP_PATH/check_curl.log | log -i -vvv
log -vvv

subheading token

if grep -q "HTTP/1.1 201 Created" "$TMP_PATH/check_curl.log"
then
  log_ok -v "Token created."
  log_ok -vv -vvv -n "Token created: "
  grep "X-Subject-Token:" "$TMP_PATH/check_curl.log" | log -i -v -vv -vvv
else
  log_error -v "No token created."
  log_error -vv -vvv -n "No token created: "
  tail -n1 "$TMP_PATH/check_curl.log" | log -i -vv -vvv
fi

log -vvv -vv
