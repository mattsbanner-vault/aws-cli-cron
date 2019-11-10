FROM debian:stretch-slim
LABEL maintainer = "Matt Banner <matt@banner.wtf>"
ENV DEBIAN_FRONTEND="noninteractive"

RUN apt-get update && apt-get install -y \
    cron curl unzip && \
    curl "https://d1vvhvl2y92vvt.cloudfront.net/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    mkdir /root/.aws/ && \
    touch /root/.aws/config && \
    touch /root/.aws/credentials && \
    rm -f /awscliv2.zip && \
    rm -rf /var/lib/apt/lists/*

ADD run.sh /root/run.sh

RUN chmod 755 /root/run.sh

CMD ["/root/run.sh"]
