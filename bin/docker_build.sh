#!/bin/bash

set -o errexit
pushd "$(cd "$(dirname "$0")" ; pwd -P )/.." > /dev/null

if [[ -f .env ]]; then
  # shellcheck disable=SC1091
  source .env
fi

for DIR in $DENV_TAGGED_IMAGES; do
  IFS='/' read -ra ARR <<< "$DIR"
  IMAGE=${ARR[0]:-base}
  TAG=${ARR[1]:-latest}

  if [[ "${DIR}" == 'base' ]]; then
    DIR='.'
  fi

  docker build \
    --no-cache \
    --build-arg "GITHUB_USERNAME=${GITHUB_USERNAME}" \
    --build-arg "DEV_DIR=${DEV_DIR}" \
    --cache-from "denv/${IMAGE}:${TAG}" \
    --tag "denv/${IMAGE}:${TAG}" \
    "${DIR}"
done

for DIR in $DENV_LATEST_IMAGES; do
  IFS='/' read -ra ARR <<< "$DIR"
  IMAGE=${ARR[0]:-base}
  TAG=${ARR[1]:-latest}
  docker tag "denv/${IMAGE}:${TAG}" "denv/${IMAGE}:latest"
done
