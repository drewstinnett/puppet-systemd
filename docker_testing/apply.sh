#!/bin/bash

set -x

echo "Starting test"
export FACTER_fqdn='testing-puppet.localdomain'
puppet apply /etc/puppet/modules/systemd/docker_testing/test.rb
cat /etc/systemd/system/test.service
echo "Finishing test"
