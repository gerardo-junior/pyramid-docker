FROM python:3.5-alpine
LABEL maintainer="Gerardo Junior <me@gerardo-junior.com>"

ENV USER pyramid
ENV WORKDIR /usr/share/src

# Install run deps
RUN apk --update add --virtual .persistent-deps \
                               sudo \
                               curl \
                               libressl \
                               libc-dev \
                               python3-dev \
                               gcc \
                               build-base

# Copy scripts
COPY ./tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set project directory
RUN mkdir -p ${WORKDIR}
VOLUME ["$WORKDIR"]
WORKDIR $WORKDIR

EXPOSE 80

RUN set -xe && \
    addgroup $USER && \
    adduser -G $USER -s /bin/sh -D $USER && \
    echo "${USER} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/default && \
    chown -Rf $USER $WORKDIR 
USER $USER
ENV PATH "${PATH}:/home/${USER}/.local/bin"

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
