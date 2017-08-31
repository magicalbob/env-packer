#!/usr/bin/env bash
set -x

sudo sh -c "cat <<EOF >/etc/yum.repos.d/vmware-tools.repo
[vmware-tools]
name = VMware Tools
baseurl = http://packages.vmware.com/packages/rhel7/x86_64/
enabled = 1
gpgcheck = 1
EOF"

sudo rpm --import https://packages.vmware.com/tools/keys/VMWARE-PACKAGING-GPG-RSA-KEY.pub

sudo yum install -y open-vm-tools open-vm-tools-deploypkg
sudo systemctl enable vmtoolsd
sudo systemctl start vmtoolsd
