---
title: "Selfhost a Minecraft Server With Docker"
date: 2022-12-19T15:22:46-05:00
draft: false
---

## Self-Hosting a Minecraft server

This is going to be quick rundown on running Minecraft as a docker container.

### Prequisite

- A computer with `docker` and `docker-compose` installed

The minecraft docker image we are using is [itzj/minecraft-server](https://github.com/itzg/docker-minecraft-server)

## The compose file

Paste the following into a `docker-compose.yml`


```yml
version: "3"

services:
  minecraft-server:
    image: itzg/minecraft-server
    container_name: my-mc-server
    ports:
      - 25565:25565
    environment:
      EULA: "TRUE"
    tty: true
    stdin_open: true
    restart: unless-stopped
    volumes:
      - ./minecraft_data:/data
```

After you have that file - run `docker-compose up -d` to run the services
in this compose file.

This is just a minimal compose file to get started... there are many many more
options that can be used to configure various runtime settings for the
minecraft server.

The documentation of the project is very good, so you are sure to find
what you are looking for there.
