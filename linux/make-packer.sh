#!/usr/bin/env bash

set -e

case ${MACHINE_SIZE,,} in
  micro)
    export DISK_SIZE="10240"
    ;; 
  normal)
    export DISK_SIZE="51200"
    ;;
  *)
    echo "Need to know MACHINE_SIZE"
    exit -1
    ;;
esac

# Get rid of output folder if it is lying around
rm -rvf output-vmware-iso

# make the kickstart file based on machine size
mustache ks/machine_${MACHINE_SIZE}.yml ks/ks.cfg.template > ks/ks.cfg

# make the packer json file based on hypervisor
mustache cloud-${CLOUD_TYPE}.yml packer-template.json.template > packer-template.json

# Build the virtual machine image
packer build packer-template.json

# If artifactory username supplied, upload image to artifactory
if [[ ${ARTIFACTORY_USERNAME} ]]
then
  CHECKSUM=$(md5sum ${OS_TYPE}-${MACHINE_SIZE}-virtualbox.box | awk '{ print $1 }')

  curl --header "X-Checksum-MD5:${CHECKSUM}" \
       -u${ARTIFACTORY_USERNAME}:${ARTIFACTORY_PASSWORD} \
       -T ${OS_TYPE}-${MACHINE_SIZE}-virtualbox.box \
       "https://dev.ellisbs.co.uk/artifactory/vagrant-local/${OS_TYPE}-${MACHINE_SIZE}.box;box_name=${OS_TYPE}-${MACHINE_SIZE};box_provider=virtualbox;box_version=${VERSION}"
fi

# If vcloud password supplied, and it is vmware image, upload image to vcloud
if [[ ${VCLOUD_PASSWORD} ]]
then
  if [ ${CLOUD_TYPE} == "vmware" ]
  then
    sh scripts/upload.sh
  fi
fi
