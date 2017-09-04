#!/bin/bash

export OS_TYPE=centos7
export ISO_URL=../iso_installation/CentOS-7-x86_64-Minimal-1611.iso
export ISO_MD5=d2ec6cfa7cf6d89e484aa2d9f830517c
export SSH_USERNAME=root
export SSH_PASSWORD=packer
export MACHINE_SIZE=normal
export CLOUD_TYPE=vmware
export VCLOUD_USER=7535.89.488a95
export VCLOUD_ORG=66-89-1-13874f
export VCLOUD_VAPP=centos7
export VCLOUD_CATALOG=PIPAT
export VCLOUD_NET=PIPAT-DEV-ROUTED
export VCLOUD_PASSWORD='qgioh(4gPou3t)'
unset  ARTIFACTORY_USERNAME

sh make-packer.sh | tee build.vmware.normal.log
