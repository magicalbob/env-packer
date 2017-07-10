#!/usr/bin/env bash

set -x

echo "Uploading to vCloud"
cd output-vmware-iso/
ovftool --vCloudTemplate --acceptAllEulas --overwrite rhel-7.2-vmware.vmx "vcloud://$VCLOUD_USER@api.vcd.portal.skyscapecloud.com:443?org=$VCLOUD_ORG&vappTemplate=$VCLOUD_VAPP&catalog=$VCLOUD_CATALOG"
cd ..
