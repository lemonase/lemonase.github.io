---
title: "Using Nobara Linux (3 month review)"
date: 2025-10-09T12:24:37-04:00
draft: false
tags:
  - gaming
  - linux
  - nobara
  - fedora
  - flatpak
---

[Nobara Linux](https://nobaraproject.org/) is a Fedora based Linux distribution by [Glorious Eggroll](https://github.com/GloriousEggroll).

This summary from the website is pretty good

> The Nobara Project, to put it simply, is a modified version of Fedora Linux with user-friendly fixes added to it. 

What fixes specifically?

> This project aims to fix most of those issues and offer a better gaming, streaming, and content creation experience out of the box. More importantly, we want to be more point and click friendly, and avoid the basic user from having to open the terminal. It’s not that the terminal and/or terminal usage are a bad thing by any means, power users are more than welcome to continue with using the terminal, but for new users, point and click ease of use is usually expected.

---

### Gaming

I installed Nobara Linux on my mini gaming PC / workstation and it has been an awesome experience.

Games perform pretty great with Wine/Proton and it is a painless experience installing the software like Discord, Spotify, and Steam.
Linux gaming has been really good in my experience. There are still some drawbacks, however a good portion
of games work on Linux and performance/compatibility is getting better. See [ProtonDB](https://www.protondb.com/) for a really easy
way to see if a game will run on Linux.

It is still not perfect, there are occasional bugs, hiccups and performance issues sure, but for the most part - I am able to just
run games without thinking about it - similar to how you would on Windows. Unless there is something obnoxious bundled with the game
like kernel level anti-cheat, most games will run just fine (maybe require some extra cmdline flags or tweaking).

It is amazing to see how far Linux gaming has come over the years.

### Fedora

Coming from using Arch and Debian based distros, there are some RedHat / Fedora-isms to pick up on (mostly getting used to `dnf` and `flatpak`)
There has not been too much tweaking that I have felt the need to do outside of window effects and desktop tweaks in KDE Plasma.

There are some extra steps to updating Nobara (since it is basically Fedora with patches) and Flatpaks as well.

I have set up an alias to do this in one swoop:

```sh
alias nobara-update-all='sudo dnf upgrade && flatpak update && sudo nobara-updater cli'
```

There is also a GUI version to update packages for Nobara without using the CLI.

### Screenfetch

Here is ~screenfetch~ fastfetch for ya:

![fastfetch](/images/posts/nobara/fastfetch.png)

Lil tip - to install fastfetch on Fedora

```
sudo dnf install fastfetch
```

### Conclusion

Overall, I am really happy with the stability and performance of Nobara and I have little reason to hop to another distro.

Unless something breaks in a way that is really annoying or unrecoverable, I am probably going to stick with Nobara for a the forseeable future (at least on this machine). XD

Thank you for reading and happy gaming!

