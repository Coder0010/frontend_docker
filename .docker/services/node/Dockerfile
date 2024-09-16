FROM node:16.14.0-alpine as node
FROM nginx:1.20-alpine
SHELL ["/bin/sh", "-oeux", "pipefail", "-c"]

ENV TZ=UTC

RUN apk update && \
    apk add --no-cache g++ && \
    apk add --no-cache --virtual .build-dependencies build-base && \
    apk del .build-dependencies && \
    apk add --no-cache libmagic && \
    rm -rf /var/cache/apk/*

# node command
COPY --from=node /usr/local/bin /usr/local/bin
# npm command
COPY --from=node /usr/local/lib /usr/local/lib
# yarn command
COPY --from=node /opt /opt

ARG DOCKER_SERVICES_PATH
COPY ${DOCKER_SERVICES_PATH}/node/conf.d/domain.conf /etc/nginx/conf.d/default.conf
COPY ${DOCKER_SERVICES_PATH}/node/ssl/server.crt /etc/nginx/ssl/server.crt
COPY ${DOCKER_SERVICES_PATH}/node/ssl/server.key /etc/nginx/ssl/server.key

WORKDIR /var/www
