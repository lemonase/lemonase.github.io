---
title: "Rat Caddy: A Simple Reverse Proxy Setup for Self-Hosters"
date: 2025-11-22T18:50:22-05:00
draft: true
tags:
  - self hosting
  - proxy
  - reverse proxy
  - config
  - network
  - tcp
  - udp
---

## The Big Picture

We are going to be looking for a **simple** way to reverse proxy traffic from
our (sub)domains on the public internet to self-hosted services at home using
**free** and **open source** software.

## How Do We Do It

The way we are going to do this is by using two reverse proxies and a VPS
machine -- not for hosting but solely for a public IP address to setup a DNS
record (and a wildcard for subdomains). We let Caddy do the work of getting
HTTPS/TLS certs.

- **[Caddy](https://github.com/caddyserver/caddy)** is a free web server and
reverse proxy
- **[Rathole](https://github.com/rathole-org/rathole)** reverse proxy that can
tunnel and traverse past NAT

I am coining the portmanteau of this nothing other
than *"The Rat Caddy"* - not to be confused with *The Cat Daddy*

## Why We Do It

The reason we are using Rathole is because we need some way to tunnel that
proxied traffic from the VPS to our local machine past NAT and other firewalls
to access that super awesome web server running on the local network.

The installation and configuration of these programs is very painless compared
to the alternatives and I will walk through the steps in a later post.

### Alternatives Considered

My journey for finding a reliable way to reverse proxy services has taken me
down a somewhat unconventional route, but I wanted to share regardless.

**Nginx**

I have used Nginx for a reverse proxy for services in the past and while it is
absolutely a solid option, I am not the biggest fan of the configuration for it
as well as Nginx Proxy Manager.

**Cloudflare**

I did use [Cloudflare
Tunnels](https://developers.cloudflare.com/cloudflare-one/networks/connectors/cloudflare-tunnel/)
for this at one point, but I found that it was really too much for my
self-hosted use case.

Also something about having to navigate through the cloudflare docs and web
portal just dragged too heavily on my soul, I knew I needed to find another
way.

**Wireguard / Tailscale**

[wireguard](https://www.wireguard.com/) based services like
[Tailscale/Headscale](https://github.com/juanfont/headscale) are also able to
do the be able to do this from a wider networking standpoint. This may be
something I look at doing in the future. It is possible that this would be
a simpler solution than Rathole.

**Other ways**

This method will not be for everyone... take a look at
[awesome-tunneling](https://github.com/anderspitman/awesome-tunneling) for some
inspiration and more options.

It is very likely you may find one or two from the list that match your use
case better.

