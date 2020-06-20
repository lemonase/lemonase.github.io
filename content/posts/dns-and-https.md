---
title: "A Bit About DNS, HTTPS, and DNS Over HTTPS"
date: 2020-06-15T15:48:39-04:00
draft: true
toc: true
images:
tags:
  - network
  - dns
  - data
  - ip
  - internet
  - protocol
---

Browsing the web involves lots of different protocols that most people probably don't consider.

DNS is one of those protocols, so in this post, we'll briefly go over the basics of DNS, and why browsers like
Firefox are switching to DNS Over HTTPS (DoH).

## What is DNS

The main function of DNS (Domain Name System) is to associate Domain Names to IP Addresses and vice versa.
The concept is deceivingly simple.

### The Application Layer

Much like HTTP and HTTPS, DNS relies on underlying protocols like IP for a Addressing, TCP and UDP for data transfer.
These lower layer protocols describe how computers get addressed, how data gets segmented, and the manner in which it gets sent over the network.
But the rest is up to the application or OS to figure out. Thankfully standard protocols have emerged and evolved, driven by committees with a vested
interest in the technology.

Allowing more and more clients to communicate with servers more efficiently is great, but often requires a
collaborative effort with everyone who makes devices, applications and servers on the internet. The history
of HTTP(s) is a good place to see this from HTTP/1.1 to HTTP/2 and HTTP/3. From SSL to TLS to encrypt web traffic.
Now we're seeing DNS sent over an encrypted channel, which is a good thing for privacy if done right.

## Protocols and Ports

The protocols mentioned so far are considered standard and have lower port numbers.
The first 1024 ports are usually reserved by the OS specifically for these protocols.
For example some common ones are:

    PROTO     PORT    NAME
    ----------------------
    TCP/UDP   22      SSH
    UDP       56      DNS
    TCP       68-69   DHCP (Dynamic Host Configuration Protocol)
    TCP       80      HTTP
    TCP       443     HTTPS
    TCP       123     NTP (Network Time Protocol)

Using `netstat -tan` or `ss -tan`, you can see all the ports that your computer is listening, or sending data to.
These commands technically show sockets, but that's another topic.

## Problem Domain

Even in the 70's, when the internet was in its infancy, people realized that computers were much better at remembering numbers than humans,
and early systems were created for mapping "hostnames" to IP Addresses. The term "hostname" and "hosts" is still used today, but
this is not to be confused with a "Domain Name" which is a similar idea, but are different identifiers.

### Hosts and Hostnames

On Linux and Unix based systems, there is a file called `/etc/hosts`, which is a plain text configuration
file containing matching ip addresses and hostnames. This effectively makes a hostname synonymous to an IP.
There is also a command `hostname` and a file called `/etc/hostname`, which contains -- you guessed it -- your hostname.
On windows, there is a `hostname` command too, but the hosts file is located at `c:\windows\system32\drivers\etc\hosts`.

An easy way to "block" a website is to use `0.0.0.0` for a hostname in your `hosts` file.

This project called [hosts](https://github.com/StevenBlack/hosts) curates and blocks bad domains using nothing but Python and a hosts file.

[PiHole](https://github.com/pi-hole/pi-hole) is another really popular project for ad-blocking at the DNS/host level. It does this by spoofing a
DNS resolver and using a blacklist that blocks known ad-domains. The setup is easy and automated and it runs on a Raspberry Pi and has Docker images.

## Setting Client DNS

You can configure what DNS resolver your computer uses, but the process will be different depending on your OS.
On a Linux distro using NetworkManager, a file called `/etc/resolv.conf` points to the DNS Server
which will resolve your lookups.

If your router provides DNS, it is probably the default for your computer, routers
typically get their DNS settings from the ISP, but this can be changed. Doing this can change
the DNS server for everyone on the network.

### Public DNS resolvers

Cloudflare hosts a public DNS server at `1.1.1.1` and claims to be "the world's fastest DNS"
and Google hosts their public dns server at `8.8.8.8`.
Here's a comprehensive list of [public DNS resolvers](https://en.wikipedia.org/wiki/Public_recursive_name_server)

### Domains and Domain Names

So Domain Names and DNS are a lot like the local `hosts` file on your computer, except
as a global distributed server that has a list of all registered domains and their IPs.

Full Domain Names have a lot more restrictions than hostnames and are generally composed
of several different fields separated by a `.` (dot).
The dot notation is tied to the recursive way that DNS resolvers search for domains.
If you don't know what that means, it's ok, we will get to what that means later.

A domain name is essentially a public record of a hostname,
so you must make an account with a registrar who can reserve
the domain on your behalf.
The price of a domain can range from $5 to tens of millions
and it all depends on scarcity and demand.

A TLD (Top Level Domain) is the last (rightmost) part of a domain.
The most common in the US being `.com` that most American companies
use. Other common TLDs include `.org .net .edu .gov`.
There are many many more TLDs, with specific purposes, like ones
for a specific countries (`.uk .jp .fr .au`),
for specific services (`.travel .jobs .bike`)
and even specific businesses (`.bmw .bosch .nike`).

A full list can be found [here](http://www.iana.org/domains/root/db).
IANA is the *Internet Assigned Numbers Authority*, and they are the
organization that gives your ISP a block of IP Addresses.
They also own the "Root Zone Database" for DNS Records.

TLDs specify the DNS Root Zone of a FQDN (Fully Qualified Domain Name), but
what about the domain itself?

### Subdomains

What comes immediately to the left of the TLD is another (child) domain name.
For example there can be a second level domain such as `.co.uk`.
This is where the "recursive" part of DNS happens as soon as you start adding subdomains.
The `.` is the one and only delimiter that separates subdomains, so domains are
nice and clean, unlike URLs.

All TLDs have at least one *subdomain* and there is no uniform specification
for how subdomains should be set up, however, there are best practices.
Some examples are `en.wikipedia.org` `mail.google.com` `www.github.com`.

Naming subdomains appropriately helps people determine their purpose.
Taking advantage of the recursive nature of DNS by setting up subdomains
can make operations much easier and more organized.
It can save organizations from registering n new domain for every new service.

### URLS

Another distinction that often confuses people is the difference between
a URL and a Domain Name. Browsers do their best to figure it out, but sometimes this doesn't work.
For example browsers automatically assume 'https://' as the scheme of the URL and port 443 or 80 
as the default port, so this leaves the user to type in the domain name,
and the ending of the URL, often refereed to as the 'slug'.

Although a URL may seem like a basic thing *to use*, it is surprising to see what characters it does and does not allow and why.
To give a run down of the syntax from the [URL Wikipedia Page](https://en.wikipedia.org/wiki/URL)

    URI = scheme:[//authority]path[?query][#fragment]
    authority = [userinfo@]host[:port]

Here we see after a `scheme:`, the `[//authority]` is often shortened to a `//host`, or the DNS
equivalent of a host -- a Domain Name. From there, a path is required. If no
path is provided, a browser will look for an "`index.html`" file in the root directory of the
web server.

URLs often require special encoding and escaping, particularly in the case of accepting user input
and sending it as a query string. There's lots more information about safely encoding a URL on
the web, so I'm not going to go into it right now, but needless to say URLs can become quite
unruly and should be constructed **very carefully**.

### Clean URLs

Having so called "clean urls" is often desired for web sites.
This method of "Rewriting" the url can be configured in either the web server,
or the web framework in the code where URLs of Requests and Responses are handled.

You will notice that the majority of web sites these days do this with their URLs.
It is a good practice to not include the name of the file, and only put information
that is absolutely necessary in the URL.

Not only does it help with SEO and web crawlers, but it also helps humans who may
need to work with those URLs.

### Slugs vs Subdomains

The decision to use URL Slugs to Subdomains often depends on the scope and size of
an organization or website in question. A thing to consider is how often or how likely the name will be changed.
Changing a subdomain can take a long time to propagate while changing a URL Slug on a server is instant.
Generally, applications will cache DNS lookups for a long time as well, but this too can be configured.

Wikipedia could have used `wikipedia.org/en/` for example, but it is unlikely
that the English version of Wikipedia will go away or change, so I think a subdomain
here is the right choice. Articles on the other hand are very likely to change, so it
makes sense to have them in the URL Slug. I think generally people are better at remembering
*Subdomains* than *URL Slugs*.

#### APIs

A pretty big grey area where you see lots of variance between slugs and subdomains is with
Web APIs. Generally, public APIs used by companies will have their own subdomain like `api.github.com`
or `api.paypal.com/v2/` `api.spotify.com/v1/`. This is a very common scheme, but there's also
endpoints that use slugs like `example.com/api/v1` or just a plain JSON file that can be requested instead of
html like `example.com/data.json`.

#### WWW.

Since we're on the topic of Domains, URLs and Slugs,
it is only appropriate to mention the `www.` subdomain prefix,
why it matters and why people still use it.

The `www.` was traditionally used to indicate what *type* of server the domain was for,
if there was any doubt whether it was `ftp` or `irc` server, you could tell by the domain.

This was never a *rule* and was never *enforced*, but has become **very common practice** over the years.
There is virtually no downside to creating a [CNAME](https://en.wikipedia.org/wiki/CNAME_record) entry for `www.yoursite.com` that
just points back to an A Record (`yoursite.com`). Another method is to use HTTP Redirects.

The best thing to do is handle and test both cases, because both ways are still pretty common, and it would
be a shame if somebody went to `www.yoursite.com` and they get a fat `ERR_NAME_NOT_RESOLVED` message,
because you forgot to redirect that traffic back to your domain.

[This Netlify article](https://www.netlify.com/blog/2017/02/28/to-www-or-not-www/)
goes over some of the reasons to use www. or not.

## Setting DNS For A Server

Registering a Domain Name is often the first step in creating a public website.
This is done at a domain name registrar like [namecheap](https://www.namecheap.com/)
or [Google Domains](https://domains.google/).

After you buy a domain, you have full rights to do whatever you like with it.
You can redirect it to any IP (even someone else's), use it as load balancer, use it as a cache, set up
DDoS protection. If you're hosting a website, you will set the A Record to point to the IP that hosts your website.

## DNS-Over-HTTPS

Traditional DNS is a plain text protocol that makes it easy for someone to snoop on a network
and see all the domain lookups.

The solution purposed for this is to move DNS over an encrypted protocol, such as HTTPS.
The RFC has been around since 2018, and Firefox kicked off this feature in browsers last year.
[Here](https://support.mozilla.org/en-US/kb/firefox-dns-over-https) is the article about it.

#### Firefox

As of February 2020, Firefox's default setting **ignores the DNS settings of your OS** and uses **their own**.

My opinion is that intentionally disregarding a user's network settings is a pretty intrusive,
even if in the name of "security" and "privacy".

Ultimately, I chalk this up to a hasty and lazy implementation of a new protocol,
but I hope they come back to respecting their user's system preferences soon.

I went back to see how Chrome and Chromium do DoH, and this is what I found.

#### Chrome

As of writing, Chrome's adoption of DoH has been slower, but it seems they are taking a much more
reasonable approach.

[This page](https://www.chromium.org/developers/dns-over-https) explains how Chrome
will try to "**upgrade the protocol** used for DNS resolution **while keeping the user’s DNS provider unchanged**"

### More Centralized DNS

Something to think about is if a critical mass of people switch to the same resolver,
it can be harmful to the distributed nature of DNS.

Think about Chrome's near 70% share in the browser market.
If they did what Firefox did, and updated Chrome to use Google's DNS by default,
it would be a massive blow to every other DNS provider out there and raise many eyebrows.

## DNS from the Command Line

There are more interesting ways that we can poke at DNS to find out more about
a certain domain.

Here's some CLI tools to get info on hosts and domains.

- `getent`
- `dig`
- `nslookup`
- `whois`

## getent

*Gets* an *entry* from NSS (Name Switch Service) Libraries.
Almost guaranteed to be on any GNU/Linux system with a network stack.

NSS libraries provide communication between code (syscalls) and
system databases found in `/etc/` like `passwd`, `group`, `hosts`, `services`.
`getent` is the command frontend for getting info from these databases -- and more.
`getent --help` should show all supported databases.

So instead of doing

```
cat /etc/hosts | grep myhostname
```

use

```
getent hosts myhostname
```

This should work for domain names too, because
the fallback for the `hosts` file is dns.

The file `/etc/nsswitch.conf` specifies the order in which the databases are searched.

So getting an IP for a host is as simple as running `getent hosts cats.com`

## dig

`dig` comes with the `dnsutils` package and provides useful DNS debugging information.
For example, it will give you the type of record, nameservers and much more.

See all the root servers

```
dig
```

Doing a regular lookup

```
dig cats.com
```

Getting the short answer

```
dig +short +noall cats.com
```

Getting nameservers

```
dig NS stackoverflow.com
```

Doing a reverse lookup

```
dig -x 74.125.196.102
```

Using another resolver

```
dig @8.8.8.8 reddit.com
```

**Tracing** a DNS lookup (this is really cool)

```
dig +trace youtube.com
```

**Tracing** a DNS lookup in **YAML**

```
dig +trace +yaml yaml.net
```

## nslookup

The functionality of `nslookup` overlaps `dig` in many ways, but
they are both good tools for poking at DNS. nslookup is also on
Windows by default.

A regular lookup (A Records)

```
nslookup yahoo.com
```

A reverse lookup

```
nslookup 98.138.219.231
```

Getting nameservers

```
nslookup -type=ns yahoo.com
```

Getting start of authority

```
nslookup -type=soa yahoo.com
```

## whois

Finally there is the `whois`, which is the tool
to use when you want *all* the possible information
on a domain.

It is worth mentioning that `whois`
is different than the other DNS tools, because
it uses a specific protocol designed for querying
databases.

`whois` goes back to the infant days of the internet.
I'll leave [this link](https://en.wikipedia.org/wiki/WHOIS)
to the Wikipedia page for anyone curious about the
history or underlying protocol.

When registering a domain, there is usually an option
to conceal your information -- specifically when
somebody performs a `whois` on your domain.

