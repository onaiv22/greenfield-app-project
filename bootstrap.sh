#!/bin/bash
yum update -y
yum install net-tools -y
yum install chrony -y 
yum install htop -y
yum install ansible -y
yum install git -y
dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y
dnf upgrade -y
systemctl start chronyd 