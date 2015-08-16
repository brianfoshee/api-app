#!/bin/bash

set -e
set -x

docker-compose up -d
docker-compose run web /app/user/bin/rake db:create db:schema:load --trace
docker-compose run web /app/user/bin/rake test
