#!/usr/bin/env bash

set -e

PACKER_TEMPLATE=centos7.json

packer build ${PACKER_TEMPLATE}

if [[ ${ARTIFACTORY_USERNAME} ]]
then
  CHECKSUM=$(md5sum packer_virtualbox-iso_virtualbox.box | awk '{ print $1 }')

  curl --header "X-Checksum-MD5:${CHECKSUM}" \
       -u${ARTIFACTORY_USERNAME}:${ARTIFACTORY_PASSWORD} \
       -T packer_virtualbox-iso_virtualbox.box \
       "https://dev.ellisbs.co.uk/artifactory/vagrant-local/centos7_pipat;box_name=centos7_pipat;box_provider=virtualbox;box_version=${VERSION}"
fi
