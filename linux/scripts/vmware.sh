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

sudo sh -c 'cat <<EOF >>/etc/rc.local
if [ \$(hostname|cut -d- -f1) != "pipat" ]
then
  new_ip=\$(vmtoolsd --cmd "info-get guestinfo.ovfenv"|grep vCloud_ip_0|grep -o 10.21.1.[0-9]*)
  new_host=\$(grep -B1 \$new_ip /etc/puppetlabs/code/environments/production/hieradata/common.yaml|head -n1|cut -d" " -f3|cut -d: -f1)
  new_host=\${new_host:1:-1}
  hostname \$new_host
  echo \$new_host > /etc/hostname
fi
EOF'
