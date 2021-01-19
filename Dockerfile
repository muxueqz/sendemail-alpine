FROM alpine:latest
MAINTAINER muxueqz - https://github.com/muxueqz

# RUN apk update && \
    # apk add ca-certificates wget perl perl-net-ssleay perl-io-socket-ssl && \
    # apk add bash && rm -rf /var/cache/apk/*
RUN apk update && \
    apk add ssmtp
ADD ./sendemail.sh /usr/bin/sendemail.sh
RUN chmod a+x /usr/bin/sendemail.sh
