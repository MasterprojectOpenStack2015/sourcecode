#!/bin/sh

if [ ! -d ~/.ssh ]
then
	mkdir ~/.ssh &>/dev/null
fi

if [ ! -f ~/.ssh/id_rsa ] 
then
	ssh-keygen -t rsa -f ~/.ssh/id_rsa -N ""
fi

cat ~/.ssh/id_rsa.pub | tools/append_once.py ~/.ssh/authorized_keys ~/.ssh/id_rsa.pub
chmod 600 ~/.ssh/authorized_keys

