#!/bin/bash

set -o errexit
pushd "$(cd "$(dirname "$0")" ; pwd -P )/.." > /dev/null

mkdir -p "$HOME/.ssh"

touch "$HOME/.bash_login" \
      "$HOME/.gitconfig" \
      "$HOME/.zsh_history"

docker-compose up -d
docker-compose exec app /bin/zsh
