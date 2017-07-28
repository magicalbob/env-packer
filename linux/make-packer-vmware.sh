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

mustache ks/machine_${MACHINE_SIZE}.yml ks/ks.cfg.template > ks/ks.cfg

PACKER_LOG=1 PACKER_LOG_PATH=./debug.log packer build packer-template-vmware.json

if [[ ${ARTIFACTORY_USERNAME} ]]
then
  CHECKSUM=$(md5sum ${OS_TYPE}-${MACHINE_SIZE}-virtualbox.box | awk '{ print $1 }')

  curl --header "X-Checksum-MD5:${CHECKSUM}" \
       -u${ARTIFACTORY_USERNAME}:${ARTIFACTORY_PASSWORD} \
       -T ${OS_TYPE}-${MACHINE_SIZE}-virtualbox.box \
       "https://dev.ellisbs.co.uk/artifactory/vagrant-local/${OS_TYPE}-${MACHINE_SIZE}.box;box_name=${OS_TYPE}-${MACHINE_SIZE};box_provider=virtualbox;box_version=${VERSION}"
fi