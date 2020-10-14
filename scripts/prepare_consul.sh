#!/usr/bin/bash

systemctl status firewalld
systemctl disable --now firewalld
sudo setenforce 0
sudo sed -i 's/^SELINUX=.*/SELINUX=Permissive/g' /etc/selinux/config
date
timedatectl
dnf install vim git unzip go -y

# Prepare for consul
groupadd --system consul
useradd -s /sbin/nologin --system -g consul consul

mkdir -p /var/lib/consul
mkdir -p /etc/consul.d
mkdir -p /var/log/consul

chown -R consul:consul /var/lib/consul
chown -R consul:consul /etc/consul.d
chown -R consul:consul /var/log/consul

# Install consul
curl -LO https://releases.hashicorp.com/consul/1.8.4/consul_1.8.4_linux_amd64.zip
unzip consul_1.8.4_linux_amd64.zip

mv consul /usr/bin
chmod +x /usr/bin/consul
consul -v