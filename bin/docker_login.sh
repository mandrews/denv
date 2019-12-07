#!/bin/bash

set -o errexit
pushd "$(cd "$(dirname "$0")" ; pwd -P )/.." > /dev/null

if [[ -f .env ]]; then
  # shellcheck disable=SC1091
  source .env
fi

if [[ -f .env.secret ]]; then
  # shellcheck disable=SC1091
  source .env.secret
fi

if [[ -z "$GITHUB_DOCKER_REGISTRY_TOKEN" ]]; then
  cat <<EOF
HINT: Save your GitHub Personal Access Token to .env.secret:
echo 'GITHUB_DOCKER_REGISTRY_TOKEN=TOKEN' >> .env.secret
EOF
else
  echo "Logging into GitHub Docker Registry"
  echo "$GITHUB_DOCKER_REGISTRY_TOKEN" | \
  docker login docker.pkg.github.com --username "$GITHUB_USERNAME" --password-stdin
fi

