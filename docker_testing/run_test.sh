#!/bin/bash
set -x
export DOCKER_HOST=tcp://
docker run -t -i local/fedroa:v3 /tmp/test_puppet.sh
