#!/bin/bash

set -e
set -x

echo "Installing docker-compose..."
curl -L https://github.com/docker/compose/releases/download/1.3.3/docker-compose-`uname -s`-`uname -m` > /home/ubuntu/bin/docker-compose
chmod +x /home/ubuntu/bin/docker-compose

echo "Starting up containers..."
docker-compose up -d
