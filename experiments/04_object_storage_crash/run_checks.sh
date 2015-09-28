source "$variables"

heading Running checks

subheading pinging object1
ping_check object1


subheading pinging object2
ping_check object2

subheading downloading created file
if [ "$1" == "" ]
then
  execute-playbook download_file.yml "Successfully downloaded file." "Unable to download file."
else
  execute-playbook download_file_fails.yml "File not accessible" "File downloaded! Impossible!"
fi

