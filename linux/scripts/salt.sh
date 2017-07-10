#!/usr/bin/env

set -x

sudo yum install -y https://repo.saltstack.com/yum/redhat/salt-repo-latest-1.el7.noarch.rpm
sudo yum install -y salt-minion
