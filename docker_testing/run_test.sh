#!/bin/bash
set -x

IMAGE_ID='local/fedora:v2'
export DOCKER_HOST=tcp://
#rsync -v -a --exclude docker_testing/ /Users/drewstinnett/src/puppet-systemd/ puppet_root/modules/systemd
#docker insert ${IMAGE_ID} file:///${BASE}/docker_testing /puppet
CONTAINER_ID=$(docker run -v /tmp:/puppet ${IMAGE_ID} git clone https://github.com/drewstinnett/puppet-systemd.git /etc/puppet/modules/systemd)
docker run $CONTAINER_ID /etc/puppet/modules/systemd/docker_testing/run_test.sh
