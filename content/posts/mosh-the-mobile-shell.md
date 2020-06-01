---
title: "Mosh the Mobile Shell"
date: 2019-08-20T08:02:28-04:00
draft: false
tags:
  - shell
  - bash
  - cli
---

### Do you have a low speed or spotty network connection

If you have ever tried using ssh from a device with a spotty Wi-Fi connection, you know that the experience can range from
less than ideal to downright infurating.

Sometimes keystrokes are not sent, the latency can be brutal, and your connection may timeout.

### Mosh to the rescue :metal:

[Mosh](https://mosh.org/) is the mobile shell that alleviates the responsiveness problems that plague ssh.
Instead of using TCP, it uses UDP so your connection can persist across network changes or putting your laptop to sleep.

The program is dead simple to install and has clients/packages for about every OS out there. It also authenticates with ssh so if you are using ssh, you can use mosh.

If you have ever struggled with the rigid connection oriented nature
of ssh and are looking for something more flexible, [try mosh](https://mosh.org/#getting).
I guarantee you it will not disappoint.
