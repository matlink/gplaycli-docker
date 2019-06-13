FROM alpine:3.8

RUN set -x \
    && apk add \
        build-base \
        gcc \
        libffi-dev \
        libxml2 \
        libxml2-dev \
        libxslt \
        libxslt-dev \
        openssl-dev \
        python3 \
        python3-dev \
        wget \
    && pip3 install \
        gplaycli \
    && wget https://raw.githubusercontent.com/matlink/gplaycli/master/gplaycli.conf -O /gplaycli.conf \
    && apk del \
        build-base \
        gcc \
        libffi-dev \
        libxml2-dev \
        libxslt-dev \
        openssl-dev \
        python3-dev \
        wget \
    && rm -rf \
        /root/.cache/pip \
        /var/cache/apk/* \
    && find /usr/ -type d -name '__pycache__' | xargs rm -rf

WORKDIR /mnt

ENTRYPOINT ["/usr/bin/gplaycli", "-c", "/gplaycli.conf"]