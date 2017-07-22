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

packer build packer-template.json

if [[ ${ARTIFACTORY_USERNAME} ]]
then
  CHECKSUM=$(md5sum packer_virtualbox-iso_virtualbox.box | awk '{ print $1 }')

  curl --header "X-Checksum-MD5:${CHECKSUM}" \
       -u${ARTIFACTORY_USERNAME}:${ARTIFACTORY_PASSWORD} \
       -T packer_virtualbox-iso_virtualbox.box \
       "https://dev.ellisbs.co.uk/artifactory/vagrant-local/centos7_pipat;box_name=centos7_pipat;box_provider=virtualbox;box_version=${VERSION}"
fi
