#!/bin/bash

set -o errexit
pushd "$(cd "$(dirname "$0")" ; pwd -P )/.." > /dev/null

if [[ -f .env ]]; then
  source .env
fi

for DIR in $DENV_LATEST_IMAGES; do
  IFS='/' read -ra ARR <<< "$DIR"
  IMAGE=${ARR[0]:-base}
  TAG=${ARR[1]:-latest}
  docker tag denv/$IMAGE:$TAG docker.pkg.github.com/$GITHUB_USERNAME/denv/$IMAGE:latest
  docker push docker.pkg.github.com/$GITHUB_USERNAME/denv/$IMAGE:latest
done

for DIR in $DENV_TAGGED_IMAGES; do
  IFS='/' read -ra ARR <<< "$DIR"
  IMAGE=${ARR[0]:-base}
  TAG=${ARR[1]:-latest}
  docker tag denv/$IMAGE:$TAG docker.pkg.github.com/$GITHUB_USERNAME/denv/$IMAGE:$TAG
  docker push docker.pkg.github.com/$GITHUB_USERNAME/denv/$IMAGE:$TAG
done
