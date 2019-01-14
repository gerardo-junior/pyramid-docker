FROM python:3.5-alpine
LABEL maintainer="Gerardo Junior <me@gerardo-junior.com>"

# Create project directory
RUN mkdir -p /usr/share/src

# Install run deps
RUN apk --update add --virtual .persistent-deps \
                               sudo \
                               curl \
                               libressl 

# Create user pyramid
RUN set -xe && \
    addgroup pyramid && \
    adduser -G pyramid -s /bin/sh -D pyramid && \
    echo "pyramid ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/default && \
    chown -Rf pyramid /usr/share/src

# Copy scripts
COPY ./tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set project directory
VOLUME ["/usr/share/src"]
WORKDIR /usr/share/src
EXPOSE 80
USER pyramid
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
