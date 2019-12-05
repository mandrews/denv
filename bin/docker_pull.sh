#!/bin/bash

set -o errexit
pushd "$(cd "$(dirname "$0")" ; pwd -P )/.." > /dev/null

for IMAGE in base java python ruby; do
  docker pull docker.pkg.github.com/$USER/denv/$IMAGE:latest
  docker tag docker.pkg.github.com/$USER/denv/$IMAGE:latest denv/$IMAGE
done

for DIR in java/11 python/2.7 python/3.7 ruby/2.5; do
  IFS='/' read -ra ARR <<< "$DIR"
  IMAGE=${ARR[0]:-base}
  TAG=${ARR[1]:-latest}
  docker pull docker.pkg.github.com/$USER/denv/$IMAGE:$TAG
  docker tag docker.pkg.github.com/$USER/denv/$IMAGE:$TAG denv/$IMAGE:$TAG
done

docker tag denv/python:3.7 denv/python:latest
docker tag denv/java:11 denv/java:latest
docker tag denv/ruby:2.5 denv/ruby:latest
