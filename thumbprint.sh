#!/bin/bash

set -e 

XT=`mktemp`

function cleanup {
  rm -f ${XT} ${XXT}
}

trap cleanup SIGHUP SIGINT SIGTERM EXIT

# format cert file
DATA=$(echo $1 | sed 's/-----BEGIN CERTIFICATE-----//g' | sed 's/-----END CERTIFICATE-----//g')
echo "-----BEGIN CERTIFICATE-----" > $XT
echo $DATA >> $XT
echo "-----END CERTIFICATE-----" >> $XT

# get thumbprint
THUMBPRINT=$(openssl x509 -in $XT -noout -fingerprint | sed 's/://g' | awk -F= '{print tolower($2)}')
THUMBPRINT_JSON="{\"thumbprint\": \"${THUMBPRINT}\"}"
echo $THUMBPRINT_JSON
