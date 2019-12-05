#!/bin/bash 

set -o errexit
pushd "$(cd "$(dirname "$0")" ; pwd -P )/.." > /dev/null

if [[ -f .env ]]; then
  source .env
fi

docker build \
  --build-arg GITHUB_USERNAME=${GITHUB_USERNAME}\
  --build-arg DEV_DIR=${DEV_DIR} \
  --cache-from denv/base:latest \
  --tag denv/base:latest .

for DIR in java/11 python/2.7 python/3.7 ruby/2.5; do
  IFS='/' read -ra ARR <<< "$DIR"
  IMAGE=${ARR[0]:-base}
  TAG=${ARR[1]:-latest}

  docker build \
    --build-arg GITHUB_USERNAME=${GITHUB_USERNAME}\
    --build-arg DEV_DIR=${DEV_DIR} \
    --cache-from denv/${IMAGE}:${TAG} \
    --tag denv/${IMAGE}:${TAG} \
    ${DIR}
done

docker tag denv/java:11 denv/java:latest
docker tag denv/python:3.7 denv/python:latest
docker tag denv/ruby:2.5 denv/ruby:latest
