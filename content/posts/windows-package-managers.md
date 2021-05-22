---
title: "The State of Windows Package Managers (2021)"
date: 2021-02-06T22:48:36-05:00
draft: false
toc: false
images:
tags:
  - windows
  - automation
  - package
  - installer
---

# Windows Package Managers

Using Linux has spoiled me when it comes to easily installing software.
The fact that there is a default package manager for every distro can be taken
for granted sometimes.
There are lots of open source, community driven package managers for
proprietary systems as well.

Mac users boast [homebrew](https://brew.sh/),
as their de facto package manager, but what about Windows?
Well I'll tell you -- Windows has had a few package managers over the years.

I'll briefly go over the 3 most popular ones:

- [winget](https://github.com/microsoft/winget-cli/) (2019, 10.5k stars, 263 commits)
- [Chocolatey](https://chocolatey.org/install) (2014, 7.2k stars, 3000 commits)
- [scoop](https://scoop.sh/) (2013, 12.5k stars, 9832 commits)

## WinGet -- "The" Windows Package Manager

### Summary

Microsoft's [winget](https://github.com/microsoft/winget-cli/) is the most recent
on the list and is still in 'preview', but is likely going to take over package
management on Windows once it becomes stable and more mature. How long that takes
I can't say, but it seems like development is going at a steady pace.

### Installing

Installing `winget` includes a few extra steps compared to the other package managers
(if you're not a "Windows Insider").
Part of the reason being Microsoft shifting the way they package new apps.
They are moving away from older formats like `.msi` to `.appxbundle` or `.appx`.

### Why does this matter?

The impact: we must install the [App Installer](https://www.microsoft.com/en-us/p/app-installer/9nblggh4nns1)
package from the Microsoft store before installing `winget` with this new installer format so we can install
programs without clicking through a GUI.

After that, you can go to the [releases](https://github.com/microsoft/winget-cli/releases/)
page on GitHub and download the latest stable or preview build
(remember the file will be a `.appxbundle`)

There may be an install script to do this, but I'll just chalk it up to being
in public "preview".

### Number of Packages

Doing `winget search | wc -l` gives me **1244** packages total. Not too bad.
It seems like they have prioritized the most popular Windows apps.

### Other thoughts

#### Good

- I have to give props on how fast searching is compared to the other tools (the project is written in C++).

#### Bad

- You cannot [list installed programs yet](https://github.com/microsoft/winget-cli/issues/119) or [uninstall programs from the CLI yet](https://github.com/microsoft/winget-cli/issues/121) (!!)

## Chocolatey

### Summary

[Chocolatey](https://chocolatey.org/install) is another super popular package
manager for Windows. [On GitHub](https://github.com/chocolatey/choco) the project
has around 7k stars and almost 3,000 commits.

### Installing

To install Chocolatey, you run this command in an Elevated (Administrator) PowerShell session.

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```

> The command just allows PowerShell to download and run a script from the internet

### Number of Packages

Chocolatey reports "There are **8170** Community Maintained Packages" [on their
website](https://chocolatey.org/packages) ranging from oldest most obscure
programs to the hottest and newest apps.
As far as I know, this is the largest collection of searchable/installable Windows
programs on the whole internet.

Someone even keeps an up-to-date package for
[Dwarf Fortress](https://chocolatey.org/packages/dwarf-fortress), which is
just awesome.

## Scoop

### Summary

[scoop](https://github.com/lukesampson/scoop) is probably the package manger I
have the least personal experience with,
but I know many people find it the easiest way to install things on Windows.
There are community made "buckets", which are similar to software repositories.
Users can decide which buckets to use and even contribute to add programs or
fix bugs.

### Installing

Installing scoop similar to installing choco. It just require downloading and
running and installer script:

```powershell
Set-ExecutionPolicy RemoteSigned -scope CurrentUser
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
```

### Number of Packages

Counting the number of packages for scoop is less straight forward than winget
or choco because the different "application buckets", but the "main" bucket has
~**800** packages and "extra" bucket has ~**1200** packages.
There are also other buckets for "games" and "nonportable".

## Final Thoughts

It seems like `winget` will most likely be _the_ windows package manager going into future
versions of Windows, but it's not ready for prime time yet, and I would argue it has quite
a ways to go before reaching feature parity with the other tools.

There are still bugs, there's no direct way to install it yet (unless you're an insider),
it has less than half of the packages of other projects and lots of missing features, but
it's also been in development a year.

In my opinion, the other two package mangers will have an edge on `winget` in
terms of stability, features, community and number of packages for some time to come.
Feel free to tell me what you think :)
