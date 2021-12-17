FROM ubuntu:focal

LABEL maintainer="tumichnix (tumichnix@daus.family)"

ENV DEBIAN_FRONTEND noninteractive
ENV APTLY_VERSION=1.4.0

RUN apt-get update \
    && apt-get -y install gnupg2 nginx supervisor wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN wget -qO - https://www.aptly.info/pubkey.txt | apt-key add - \
    && echo "deb http://repo.aptly.info/ squeeze main" > /etc/apt/sources.list.d/aptly.list

RUN apt-get update \
    && apt-get -y install aptly=$APTLY_VERSION \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY assets/aptly.conf /root/.aptly.conf

COPY assets/vhost.conf /etc/nginx/sites-enabled/default

COPY assets/supervisord.conf /etc/supervisor/supervisord.conf

VOLUME [ "/opt/aptly" ]

EXPOSE 80 8080

CMD ["/usr/bin/supervisord"]