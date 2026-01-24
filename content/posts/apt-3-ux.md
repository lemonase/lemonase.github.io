---
title: "Apt 3 UX Improvement"
date: 2026-01-24T12:27:50-05:00
draft: false
---

About a year ago, Debian maintainers have updated APT (packaging tool)
to improve the UX / readability of the output when updating and upgrading
packages.

[Here](https://www.reddit.com/r/debian/comments/1c2kxeh/welcome_the_new_apt_30_ux_refined_solution_screen/)
is the reddit post about this change on [/r/debian](https://www.reddit.com/r/debian/)

The difference can be seen below:

```
~ $ apt --version
apt 2.8.3 (amd64)
```

![apt2](images/posts/apt3-ux/apt2.png)

---

```
jam@deblet2:~$ apt --version
apt 3.0.3 (amd64)
```

![apt3](images/posts/apt3-ux/apt3.png)

This is a much welcome change in my opinion. Shouts out to Debian maintainers, great work!
