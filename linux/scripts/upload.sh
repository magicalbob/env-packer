#!/usr/bin/env bash

set -x

echo "Uploading to vCloud"
rm -rvf tmp.ovf
ovftool --vCloudTemplate --acceptAllEulas --overwrite output-vmware-iso/centos7.vmx tmp.ovf/centos7.ovf
scripts/ovf-patch.py > tmp.ovf/centos7/centos7new.ovf
echo $VCLOUD_PASSWORD|ovftool --vCloudTemplate="true" --acceptAllEulas --overwrite tmp.ovf/centos7/centos7new.ovf "vcloud://$VCLOUD_USER@api.vcd.portal.skyscapecloud.com:443?org=$VCLOUD_ORG&vappTemplate=$VCLOUD_VAPP-$MACHINE_SIZE&catalog=$VCLOUD_CATALOG"
