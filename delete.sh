#!/bin/bash

baseurl='"localhost:8081"'
#login="azkaban"
crurl="$baseurl/manager?action=create"
durl="$baseurl/manager"
#password="azkaban"
read -p "Host: " baseurl
read -p "Username: " login
read -s -p "Password: " password
num=10

cmd="(curl -k -X  POST --data \"action=login&username=$login&password=$password\" $baseurl -c cookies.txt)"   

eval $cmd

for i in $(seq 1 $num) ; do
	#delete project
        delete="(curl -b cookies.txt -k  --get --data \"delete=true&project=b$i\" $durl)"
	eval $delete
done


#clear the session data file
rm cookies.txt
