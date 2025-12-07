---
title: "SSH Port Forwarding & Tunneling"
date: 2025-11-26T20:00:55-05:00
draft: false
tags:
  - ssh
  - server
  - network
  - ports
  - linux
---

The most common use case for `ssh` is to securely access a shell on a remote
systems. However `ssh` is also very useful for Port Forwarding (sometimes
called tunneling if done in reverse).

I initially had a hard time wrapping my head around the difference between
forward and reverse when it comes to ports and traffic. I have definitely
searched how to do this and done it myself a few times before it stuck.

Upon searching for clarification - there are many Stack Overflow posts with
examples, a few Reddit posts as well as some other blogs (some were very
helpful others not so much).

This is my rundown of the topic.

### Port Forwarding

Port forwarding is done by specifying the `-L` flag and most commonly done
for a given port on `localhost`. It will basically bind a specified port on
your local machine to the remote port.

This is handy if you have a local development server running on a remote
machine (say it is only listening on `localhost` or `127.0.0.1`) and you want
to access that from your local machine. It is possible through the invisible
port magic of ssh.

You would do something like this:

```
ssh -L 8080:localhost:8080 user@cloud-dev-machine.xyz
```

Suddenly your local machines port `localhost:8080` becomes the remote machine's port
`cloud-dev-machine:8080`

- [man
page](https://man7.org/linux/man-pages/man1/ssh.1.html#:~:text=%2DL%20%5Bbind_address,from%20all%20interfaces.)

### Reverse Tunneling

> NOTE: Please consider the security implications of exposing local ports to
> the public internet **before** doing anything below.

Tunneling traffic back to your local machine from the remote host can be done
in a similar fashion with the `-R` flag.

This is useful if you have a remote machine (say a public server) and you want
to have a port on a local machine (on your local network) be accessible through
a specific port on a  public server.

#### SSH Daemon Configuration

There is one extra configuration step and that is editing the `sshd_config` on
the remote machine must have `GatewayPorts` enabled or set to yes. This is done
by:

First editing the sshd config on the remote machine

```
sudo vim /etc/ssh/sshd_config
```

Add the following line to `/etc/ssh/sshd_config`

```
GatewayPorts yes
```

Reload the ssh daemon

```
sudo systemctl reload sshd
```

#### SSH Client

An example of the client command for this is:

```
ssh -R 8999:localhost:8999 user@dev-machine.xyz
```

After connecting this way, your local port `localhost:8999` will be bound on
the remote machine and essentially `dev-machine.xyz:8999` will be tunneled back
to `localhost`. This method will bypass NAT and basic firewall rules, so do be
mindful of security.

- [man
page](https://man7.org/linux/man-pages/man1/ssh.1.html#:~:text=%2DR%20%5Bbind_address,the%20standard%20output.)

### Background SSH

There are other options that may be helpful using `ssh` this way. Notably `-N`
and `-n` which tell ssh to run no commands and ignore input/output.

- [man
page](https://man7.org/linux/man-pages/man1/ssh.1.html#:~:text=%2DN%20%20%20%20%20%20Do%20not%20execute%20a%20remote%20command,StdinNull%20in%20ssh_config(5)%20for%20details.)

## Conclusion

SSH can be a very useful tool for directing port traffic between `localhost`
and remote server(s) during development/testing. A little bit of network
knowledge and configuration is all it takes to forward or tunnel network
traffic with `ssh`.

