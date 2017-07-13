#!/usr/bin/env

set -x

sudo yum install -y https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
sudo yum install -y puppet-agent
sudo su -c "echo Defaults secure_path = /sbin:/bin:/usr/sbin:/usr/bin:/opt/puppetlabs/bin >> /etc/sudoers.d/puppet"
