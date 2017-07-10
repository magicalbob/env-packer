#!/usr/bin/env

set -x

sudo yum erase -y firewalld
sudo yum install -y iptables-services
sudo systemctl enable iptables
