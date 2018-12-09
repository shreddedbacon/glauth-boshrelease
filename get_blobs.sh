#!/bin/bash
set -e

DIR=`pwd`

mkdir -p .downloads
cd .downloads

if [ -f ${DIR}/blobs/glauth/glauth ]; then
  curl -L https://github.com/glauth/glauth/releases/download/v1.1.0/glauth64 > glauth
  bosh add-blob --dir=${DIR} glauth glauth/glauth
fi

cd -

