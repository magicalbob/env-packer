#!/usr/bin/env bash

set -e

packer build -force windows.json

# If artifactory username supplied, upload image to artifactory
if [[ ${ARTIFACTORY_PASSWORD} ]]
then
  CHECKSUM=$(md5sum windows2016-virtualbox.box | awk '{ print $1 }')

  curl --header "X-Checksum-MD5:${CHECKSUM}" \
       -u${ARTIFACTORY_USERNAME}:${ARTIFACTORY_PASSWORD} \
       -T windows2016-virtualbox.box \
       "https://dev.ellisbs.co.uk/artifactory/vagrant-local/windows.box;box_name=windows;box_provider=virtualbox;box_version=${VERSION}"
fi
