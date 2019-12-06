#!/bin/bash

set -o errexit
pushd "$(cd "$(dirname "$0")" ; pwd -P )/.." > /dev/null

DENV_HOME=$HOME/.denv
DENV_TMP_ZIP=$(mktemp)
DENV_TMP_DIR=$(mktemp -d)
curl -L https://github.com/mandrews/denv/archive/master.zip > $DENV_TMP_ZIP
unzip $DENV_TMP_ZIP -d $DENV_TMP_DIR
mv $DENV_TMP_DIR/denv-master $HOME/.denv
rm $DENV_TMP_ZIP
rm -rf $DENV_TMP_DIR

pushd $DENV_HOME
bin/docker_pull.sh

cat <<-EOF
To finish install:
echo 'export PATH="\$PATH:\$HOME/.denv/bin"' >> ~/.bash_login
echo 'exec \$HOME/.denv/bin/denv' >> ~/.bash_login
EOF
