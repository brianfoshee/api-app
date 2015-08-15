#!/bin/bash

set -e
set -x

heroku plugins:install heroku-docker
heroku docker:release --app pure-hamlet-9980
