#!/bin/bash

export OS_TYPE=centos7
export ISO_URL=../iso_installation/CentOS-7-x86_64-Minimal-1511.iso
export ISO_MD5=88c0437f0a14c6e2c94426df9d43cd67
export SSH_USERNAME=root
export SSH_PASSWORD=packer
export MACHINE_SIZE=micro
unset  ARTIFACTORY_USERNAME

sh make-packer-vmware.sh | tee build.log
