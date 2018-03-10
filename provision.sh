#!/bin/bash

#install and setup
yum update -y
yum install nginx -y
chkconfig nginx on
aws s3 cp s3://buhr3940-assigment4-t2/index.html /usr/share/nginx/html/index.html
service nginx start

# assign variables
ACTION=${1}
version='1.0.0'

#remove function

function remove_files() {

service nginx stop
rm /usr/share/nginx/html/*.html
yum remove nginx

}

function show_version() {

echo $version

}

function display_help() {

cat << EOF
Usage:  ${0} {-r|--remove|-h|--help|-v|--version}
OPTIONS:
	-r | --remove   Remove nginx and web files
	-h | --help	Display the command help
	-v | --version  Show the version of script 
Examples:
	Remove ngnix and web files:
		$ ${0} -r
	Display help:
		$ ${0} -h
        Show version:
                $ ${0} -v
EOF
}

case "$ACTION" in
	-h|--help)
		display_help
		;;
	-r|--remove)
		remove_files 
		;;
	-v|--version)
                show_version
                ;;
	*)
	echo "Usage ${0} {-r|-h|-v}"
	exit 1
esac
