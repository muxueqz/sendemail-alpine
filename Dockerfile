FROM alpine:latest
MAINTAINER muxueqz - https://github.com/muxueqz

RUN apk update && \
    apk add ssmtp && \
    rm -rf /var/cache/apk/*
COPY entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
