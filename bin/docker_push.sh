#!/bin/bash

set -o errexit
pushd "$(cd "$(dirname "$0")" ; pwd -P )/.." > /dev/null

for IMAGE in base java python ruby; do
  docker tag denv/$IMAGE docker.pkg.github.com/$USER/denv/$IMAGE:latest
  docker push docker.pkg.github.com/$USER/denv/$IMAGE:latest
done

for DIR in java/11 python/2.7 python/3.7 ruby/2.5; do
  IFS='/' read -ra ARR <<< "$DIR"
  IMAGE=${ARR[0]:-base}
  TAG=${ARR[1]:-latest}
  docker tag denv/$IMAGE:$TAG docker.pkg.github.com/$USER/denv/$IMAGE:$TAG
  docker push docker.pkg.github.com/$USER/denv/$IMAGE:$TAG
done

