#!/usr/bin/env bash

set -e

export ISO_URL=~/Downloads/CentOS-7-x86_64-Minimal-1611.iso
export ISO_MD5=d2ec6cfa7cf6d89e484aa2d9f830517c
export SSH_USERNAME=root
export SSH_PASSWORD=packer

packer build centos7.json

vagrant box add -f centos7_pipat packer_virtualbox-iso_virtualbox.box
