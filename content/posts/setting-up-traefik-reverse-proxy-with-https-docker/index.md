---
title: "Setting Up Traefik Reverse Proxy (with HTTPS) - Docker Compose"
date: 2022-12-20T23:59:21-05:00
draft: false
tags:
  - traefik
  - docker
  - reverse-proxy
  - https
---

## Setting Up Traefik Reverse Proxy

[Traefik](https://github.com/traefik/traefik) is a reverse proxy program often
used with docker to route web requests to different services on the backend.

It also has some really handy features like automatic HTTPS certs and
a configuration syntax based on labels that makes it relatively easy to add
to existing `docker-compose` files or even Docker Swarm and Kubernetes.

Be sure to look at [the docs](https://doc.traefik.io/traefik/getting-started/concepts/)
to get a better overview.

## Using Traefik as a reverse proxy to Wordpress example

Here is the `docker-compose.yml` example that has Traefik as a HTTPS proxy sitting
in front of a `wordpress` and `whoami` service.

This file is also taken from the [Traefik docs](https://doc.traefik.io/traefik/user-guides/docker-compose/acme-tls/)
but slightly modified to add Wordpress to the mix.

Notice: 
The arguments for `command:` passed to Traefik are the default configuraion.
The `labels:` for `wordpress` and `whoami` direct - or inform Traefik on things like hostname, resolver and cert.

```yml
# docker-compose.yml
version: "3.3"

services:

  traefik:
    image: "traefik:v2.9"
    container_name: "traefik"
    command:
      # log level will make logs more verbose (for debugging ssl/tls certs)
      # - "--log.level=DEBUG"
      - "--api.insecure=true"
      - "--providers.docker=true"
      - "--providers.docker.exposedbydefault=false"
      - "--entrypoints.websecure.address=:443"
      - "--certificatesresolvers.myresolver.acme.tlschallenge=true"
      # using the "staging" ca server for letsencrypt is better for testing (less rate limiting)
      # - "--certificatesresolvers.myresolver.acme.caserver=https://acme-staging-v02.api.letsencrypt.org/directory"
      - "--certificatesresolvers.myresolver.acme.email=${LETSENCRYPT_EMAIL}"
      - "--certificatesresolvers.myresolver.acme.storage=/letsencrypt/acme.json"
    ports:
      - "443:443"
        # port 8080 is for traefik's builtin dashboard. traefik can be run without
        # - "8080:8080"
    volumes:
      # store certs in current working directory
      - "./letsencrypt:/letsencrypt"
      - "/var/run/docker.sock:/var/run/docker.sock:ro"

  whoami:
    image: "traefik/whoami"
    container_name: "simple-service"
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.whoami.rule=Host(`whoami.example.com`)"
      - "traefik.http.routers.whoami.entrypoints=websecure"
      - "traefik.http.routers.whoami.tls.certresolver=myresolver"

  wordpress:
    image: wordpress
    container_name: "${DEFAULT_HOST}-wordpress"
    restart: unless-stopped
    environment:
      WORDPRESS_DB_HOST: "${WORDPRESS_DB_HOST}"
      WORDPRESS_DB_USER: "${WORDPRESS_DB_USER}"
      WORDPRESS_DB_PASSWORD: "${WORDPRESS_DB_PASSWORD}"
      WORDPRESS_DB_NAME: "${WORDPRESS_DB_NAME}"
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.wordpress.rule=Host(`example.com`)"
      - "traefik.http.routers.wordpress.entrypoints=websecure"
      - "traefik.http.routers.wordpress.tls.certresolver=myresolver"
    volumes:
      - wordpress:/var/www/html

  db:
    image: mysql:5.7
    container_name: "${DEFAULT_HOST}-mysql"
    restart: unless-stopped
    environment:
      MYSQL_DATABASE: "${MYSQL_DATABASE}"
      MYSQL_USER: "${MYSQL_USER}"
      MYSQL_PASSWORD: "${MYSQL_PASSWORD}"
      MYSQL_RANDOM_ROOT_PASSWORD: '1'
    volumes:
      - db:/var/lib/mysql

volumes:
  wordpress:
  db:
```

So in effect - if all goes correctly running `docker-compose up`, then:

`https://whoami.example.com` will route requests to `whoami`
`https://example.com` will route requests to `wordpress`

## Troubleshooting

The logs for traefik are generally very helpful in debugging issues. Usually
it is something DNS/TLS/port related.


