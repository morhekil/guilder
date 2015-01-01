#!/bin/bash

set -e # exit on first error
set -x

BUILD_DIR=/build/go
DIST_DIR=/dist
SRC_DIR=$BUILD_DIR/src/$PKG

source /etc/profile

# Prepare the directory structure
export GOPATH=$BUILD_DIR

# Get the repo auth key
# wget -O ~/.ssh/`basename "$KEY"` "$KEY"
mkdir -p ~/.ssh
echo "$KEY" > ~/.ssh/id_rsa
chmod 400 ~/.ssh/id_rsa

# Checkout private repositories if they don't exist
if [ ! -d $SRC_DIR ]; then
  git clone $GIT $SRC_DIR
fi;

# Symlink the dist dir
ln -s $DIST_DIR ${SRC_DIR}${DIST_DIR}

# Build the project
cd $SRC_DIR
make
