#!/usr/bin/env bash

set -x

echo "Uploading to vCloud"
ovftool --vCloudTemplate --acceptAllEulas --overwrite output-vmware-iso/centos7.vmx tmp.ovf/centos7.ovf
cot -f -v edit-hardware tmp.ovf/centos7/centos7.ovf -o tmp.ovf/centos7/centos7new.ovf -N ${VCLOUD_NET} --network-descriptions "VM Network"
echo $VCLOUD_PASSWORD|ovftool --vCloudTemplate --acceptAllEulas --overwrite tmp.ovf/centos7/centos7new.ovf "vcloud://$VCLOUD_USER@api.vcd.portal.skyscapecloud.com:443?org=$VCLOUD_ORG&vappTemplate=$VCLOUD_VAPP&catalog=$VCLOUD_CATALOG"
