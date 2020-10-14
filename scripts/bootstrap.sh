#!/usr/bin/bash

echo "Update /etc/hosts file"
cat >/etc/hosts<<EOF
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
192.168.0.31 pdb01
192.168.0.32 pdb02
192.168.0.33 pdb03
EOF

echo "Set SELinux to permissive mode"
sudo setenforce 0
sudo sed -i 's/^SELINUX=.*/SELINUX=Permissive/g' /etc/selinux/config

echo "Set timezone to Europe/Moscow"
timedatectl set-timezone Europe/Moscow

echo "Update system"
dnf update -y

echo "Install utilities"
dnf install vim git unzip tmux -y
