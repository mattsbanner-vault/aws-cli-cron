# AWS CLI Cron
**AWS CLI 2**

Simple docker container, for running AWS CLI commands via Cron.

Built for syncing to S3 buckets, so likely missing a lot of features outside of that. As and when my AWS usage is increased, I may well add more to this project. In the meantime, please feel free to submit a PR.

Please report all [issues](https://github.com/mattsbanner/aws-cli-cron/issues) on GitHub rather than DockerHub.

## Setup
Use the example Docker Compose file in this repository to setup the container. 3 environment variables are required. An AWS Access Key ID, an AWS Secret Access Key and the default region to use.

You will also need to mount the volume `/resource` within the container. This should contain a single file called `cron` where your cron jobs will sit.

Then you're simply free to add in any further volumes you may require.

**Example Cron Job**
```
* * * * * root aws2 s3 sync /mnt/data01/Test s3://test-bucket/test --storage-class=DEEP_ARCHIVE --delete --exclude .DS_Store >> /var/log/cron.log 2>&1
```
