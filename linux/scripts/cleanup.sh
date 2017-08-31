#!/usr/bin/env bash
set -x

# Clear out ifcfg-eth0
sudo rm -vf /etc/sysconfig/network-scripts/ifcfg-eth0

# Add net.ifnames to /etc/default/grub and rebuild grub.cfg
sudo sed -i -e '/GRUB_CMDLINE_LINUX/ s:"$: net.ifnames=0":' /etc/default/grub
sudo /sbin/grub2-mkconfig -o /boot/grub2/grub.cfg

# Clean up yum
yum clean all
yum makecache

# Remove ssh host keys
sudo rm -rvf /etc/ssh/ssh_host*_key*

# Clean up /root
sudo rm -vf /root/anaconda-ks.cfg
sudo rm -vf /root/install.log
sudo rm -vf /root/install.log.syslog
sudo rm -rvf /root/.pki

# Clean up /var/log
sudo sh -c ">/var/log/cron"
sudo sh -c ">/var/log/dmesg"
sudo sh -c ">/var/log/lastlog"
sudo sh -c ">/var/log/maillog"
sudo sh -c ">/var/log/messages"
sudo sh -c ">/var/log/secure"
sudo sh -c ">/var/log/wtmp"
sudo sh -c ">/var/log/audit/audit.log"
sudo sh -c ">/var/log/rhsm/rhsm.log"
sudo sh -c ">/var/log/rhsm/rhsmcertd.log"
sudo rm -f /var/log/*.old
sudo rm -f /var/log/*.log
sudo rm -f /var/log/*.syslog

# Clean /tmp
sudo rm -rvf /tmp/*

# Zero out the free space to save space in the final image
sudo dd if=/dev/zero of=/EMPTY bs=1M
sudo rm -vf /EMPTY

# Clear history
sudo sh -c ">/root/.bash_history"

# Run puppet apply on start up
sudo sh -c 'cat <<EOF >>/etc/rc.local

# Turn on process accounting
/sbin/accton on

# Run puppet manifest (which will cron running puppet manifest at quarter past every hour)
/opt/puppetlabs/bin/puppet apply /etc/puppetlabs/code/environments/production/manifests/linux_manifest.pp
EOF'
sudo chmod +x /etc/rc.local
