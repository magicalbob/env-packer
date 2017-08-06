#!/usr/bin/env

set -x

sudo useradd vagrant
sudo usermod -a -G wheel vagrant
sudo su -c "echo vagrant | passwd --stdin vagrant"
sudo mkdir -p /vagrant
sudo chown vagrant:vagrant /vagrant
sudo mkdir -p ~vagrant/.ssh
sudo echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ==" > ~vagrant/.ssh/authorized_keys
sudo chmod 700 ~vagrant/.ssh
sudo chmod 600 ~vagrant/.ssh/authorized_keys
sudo chown -R vagrant:vagrant ~vagrant/.ssh
sudo su -c 'echo "%vagrant  ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers'

# Mount the disk image
cd /tmp
mkdir /tmp/isomount
mount -t iso9660 -o loop /root/VBoxGuestAdditions.iso /tmp/isomount

# Install bzip2
sudo yum install -y bzip2 make gcc kernel-devel

export KERN_DIR=/usr/src/kernels/$(uname -r|cut -d. -f1-3)*

# Install the drivers
/tmp/isomount/VBoxLinuxAdditions.run

# Cleanup
umount isomount
rm -rf isomount # /root/VBoxGuestAdditions.iso
