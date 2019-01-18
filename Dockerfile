ARG PYTHON_VERSION="3.5"

FROM python:$PYTHON_VERSION-alpine

LABEL maintainer="Gerardo Junior <me@gerardo-junior.com>"
LABEL url="https://github.com/gerardo-junior/pyramid-docker.git"

ENV USER pyramid
ENV WORKDIR /src

# Install run deps
RUN apk --update add --virtual .persistent-deps \
                               sudo \
                               curl \
                               libressl \
                               libc-dev \
                               python3-dev \
                               gcc \
                               build-base


# Set project directory
RUN mkdir -p ${WORKDIR}

RUN set -xe && \
    addgroup $USER && \
    adduser -G $USER -s /bin/sh -D $USER && \
    echo "${USER} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/default && \
    chown -Rf $USER $WORKDIR

COPY ./tools /opt/tools
RUN chmod -R +x /opt/tools/

VOLUME [$WORKDIR]
WORKDIR $WORKDIR
EXPOSE 80
USER $USER
ENTRYPOINT ["/bin/sh", "/opt/tools/entrypoint.sh"]
