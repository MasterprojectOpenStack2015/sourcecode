#!/bin/bash

heading SETUP

subheading "uploading a file"
execute-playbook upload_file.yml "Successfully uploaded file" "Failed to upload file."
exit $?