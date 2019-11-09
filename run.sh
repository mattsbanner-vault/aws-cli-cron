#!/bin/bash

set -o pipefail
set -o errexit

MODE="$1"
CRONFILE="/etc/cron.d/awscli"

touch $CRONFILE
echo "" >> $CRONFILE
echo "$(cat /resource/cronjobs/cron)" >> $CRONFILE
echo "" >> $CRONFILE

# Check & Set
AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID:?"AWS_ACCESS_KEY_ID missing"}
AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY:?"AWS_SECRET_ACCESS_KEY missing"}
AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION:?"AWS_DEFAULT_REGION missing"}

# Create Config Files
echo "[default]" >> /root/.aws/config
echo "[default]" >> /root/.aws/credentials
echo "region = $AWS_DEFAULT_REGION" >> /root/.aws/config
echo "aws_access_key_id = $AWS_ACCESS_KEY_ID" >> /root/.aws/credentials
echo "aws_secret_access_key = $AWS_SECRET_ACCESS_KEY" >> /root/.aws/credentials

exec /usr/sbin/cron -f
