#!/bin/bash

set -o errexit
pushd "$(cd "$(dirname "$0")" ; pwd -P )/.." > /dev/null

if [[ -f .env ]]; then
  source .env
fi

docker pull alpine

for DIR in $DENV_LATEST_IMAGES; do
  IFS='/' read -ra ARR <<< "$DIR"
  IMAGE=${ARR[0]:-base}
  docker pull docker.pkg.github.com/$GITHUB_USERNAME/denv/$IMAGE:latest
  docker tag docker.pkg.github.com/$GITHUB_USERNAME/denv/$IMAGE:latest denv/$IMAGE:latest
done

for DIR in $DENV_TAGGED_IMAGES; do
  IFS='/' read -ra ARR <<< "$DIR"
  IMAGE=${ARR[0]:-base}
  TAG=${ARR[1]:-latest}
  docker pull docker.pkg.github.com/$GITHUB_USERNAME/denv/$IMAGE:$TAG
  docker tag docker.pkg.github.com/$GITHUB_USERNAME/denv/$IMAGE:$TAG denv/$IMAGE:$TAG
done
