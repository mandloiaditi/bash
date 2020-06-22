#!/bin/bash

baseurl='"localhost:8081"'
#login="azkaban"
crurl="$baseurl/manager?action=create"
durl="$baseurl/manager"
#password="azkaban"
read -p "Host: " baseurl
read -p "Username: " login
read -s -p "Password: " password
cmd="(curl -s  -k -X  POST --data \"action=login&username=$login&password=$password\" $baseurl -c cookies.txt)"   
num=10
eval $cmd

for i in $(seq 1 $num) ; do
	#create project
        create="(curl -b cookies.txt -s -k -X POST --data \"name=b$i&description=testproject\" $crurl)"
	eval $create
	#upload zip
	upload="(curl -b cookies.txt -s -i -X POST --form 'ajax=upload' --form 'file=@myproject.zip;type=application/zip' --form 'project=b$i' $durl)"
	eval $upload	
done

#clear the session data file
rm cookies.txt
