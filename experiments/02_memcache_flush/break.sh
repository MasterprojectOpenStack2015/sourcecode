#!/bin/bash

heading CREATING FAULT

source "$variables"

subheading "flushing memcache on controller"

ssh ubuntu@controller "echo flush_all | nc localhost 11211" | log -vvv -i


