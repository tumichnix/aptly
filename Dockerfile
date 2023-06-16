FROM ubuntu:23.04

LABEL maintainer="tumichnix (tumichnix@daus.family)"

ENV DEBIAN_FRONTEND noninteractive
ENV APTLY_VERSION=1.5.0+ds1-1

RUN apt-get update \
    && apt-cache show aptly \
    && apt-get -y install gnupg2 nginx supervisor wget aptly=$APTLY_VERSION \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY assets/aptly.conf /root/.aptly.conf

COPY assets/vhost.conf /etc/nginx/sites-enabled/default

COPY assets/supervisord.conf /etc/supervisor/supervisord.conf

VOLUME [ "/opt/aptly" ]

VOLUME [ "/root/.gnupg" ]

EXPOSE 80 8080

CMD ["/usr/bin/supervisord"]