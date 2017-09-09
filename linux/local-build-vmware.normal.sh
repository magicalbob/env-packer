#!/bin/bash

export OS_TYPE=centos7
export ISO_URL=../iso_installation/CentOS-7-x86_64-Minimal-1611.iso
export ISO_MD5=d2ec6cfa7cf6d89e484aa2d9f830517c
export SSH_USERNAME=root
export SSH_PASSWORD=packer
export MACHINE_SIZE=normal
export CLOUD_TYPE=vmware
unset  ARTIFACTORY_USERNAME

sh make-packer.sh | tee log/build.normal.log
