#!/bin/bash

set -o pipefail
set -o errexit

# Echo cronjobs to cron file
CRONFILE="/etc/cron.d/awscli"
touch $CRONFILE
echo "" >> $CRONFILE
echo "$(cat /resource/cron)" >> $CRONFILE
echo "" >> $CRONFILE

# Check & Set
AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID:?"AWS_ACCESS_KEY_ID missing"}
AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY:?"AWS_SECRET_ACCESS_KEY missing"}
AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION:?"AWS_DEFAULT_REGION missing"}

# If there is no AWS config, make one
if [[ ! -e /root/.aws/config ]]; then
  touch /root/.aws/config
  echo "[default]" >> /root/.aws/config
  echo "region = $AWS_DEFAULT_REGION" >> /root/.aws/config
fi

# If there are no AWS credentials, make some
if [[ ! -e /root/.aws/credentials ]]; then
  touch /root/.aws/credentials
  echo "[default]" >> /root/.aws/credentials
  echo "aws_access_key_id = $AWS_ACCESS_KEY_ID" >> /root/.aws/credentials
  echo "aws_secret_access_key = $AWS_SECRET_ACCESS_KEY" >> /root/.aws/credentials
fi

exec /usr/sbin/cron -f
