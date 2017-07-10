#!/usr/bin/env bash
set -x

# Add net.ifnames to /etc/default/grub and rebuild grub.cfg
sudo sed -i -e '/GRUB_CMDLINE_LINUX/ s:"$: net.ifnames=0":' /etc/default/grub
sudo /sbin/grub2-mkconfig -o /boot/grub2/grub.cfg

# Disable udev network rules
sudo ln -s /dev/null /etc/udev/rules.d/80-net-name-slot.rules

# Clean up yum
yum clean all
yum makecache

# Remove ssh host keys
sudo rm -rf /etc/ssh/ssh_host*_key*

# Clean up /root
sudo rm -f /root/anaconda-ks.cfg
sudo rm -f /root/install.log
sudo rm -f /root/install.log.syslog
sudo rm -rf /root/.pki

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
sudo rm -rf /tmp/*

# Zero out the free space to save space in the final image
sudo dd if=/dev/zero of=/EMPTY bs=1M
sudo rm -f /EMPTY

# Clear history
# sudo history -c
