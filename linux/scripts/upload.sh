#!/usr/bin/env bash

set -x

echo "Uploading to vCloud"
rm -rvf tmp.ovf
ovftool --vCloudTemplate --acceptAllEulas --overwrite output-vmware-iso/centos7.vmx tmp.ovf/centos7.ovf
sed 's/ovf:id="1" vmw:osType=".otherLinuxGuest"/ovf:id="101" vmw:osType="centos64Guest"/' tmp.ovf/centos7/centos7.ovf > tmp.ovf/centos7/centos7new.ovf
cot -f -v edit-hardware tmp.ovf/centos7/centos7new.ovf -o tmp.ovf/centos7/centos7.ovf -N ${VCLOUD_NET} --network-descriptions "VM Network"
openssl sha256 tmp.ovf/centos7/centos7.ovf tmp.ovf/centos7/centos7-disk1.vmdk > tmp.ovf/centos7/centos7.mf
echo $VCLOUD_PASSWORD|ovftool --vCloudTemplate="true" --X:vCloudEnableGuestCustomization="true" --acceptAllEulas --overwrite tmp.ovf/centos7/centos7.ovf "vcloud://$VCLOUD_USER@api.vcd.portal.skyscapecloud.com:443?org=$VCLOUD_ORG&vappTemplate=$VCLOUD_VAPP-$MACHINE_SIZE&catalog=$VCLOUD_CATALOG"
