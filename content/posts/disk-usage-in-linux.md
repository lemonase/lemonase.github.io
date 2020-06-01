---
title: "Disk Usage in Linux"
date: 2020-05-27T11:05:17-04:00
draft: false
toc: true
images:
tags:
  - du
  - df
  - disk usage
  - command
  - visualize
---

## Disk usage by partition

Checking on disk usage of mounted partitions in linux is one command.

```shell
df -h
```

The `-h` makes the output human readable (think MB, GB instead of bytes or kilobytes)

## Disk usage by directory

The command used to check disk usage of directories on Linux is `du`.

Note the regular output is in kilobytes, but like other utils that work with filesize, adding `-h` will make the results human readable.

Also the default behaviour is to recursively go through all the files in the directories provided (or the current directory).
Think of commands like `ls -R` or `find`.

Adding a `-s` will "summarize" the output instead of recursing into the directories provided. There is also a `-c` option
to give a total at the end.

The command I use all the time to see what is taking up the most space is:

```shell
du -shc * | sort -hr
```

## Graphical tools

All kinds of awesome scripts and programs exist to visualize disk usage in creative ways.

Tools like `ncdu` to `duc` provide alternative ways to see disk usage with a curses like interface.

I found one installed on my system with KDE called `Filelight` which lays out files in a cool pie chart.
It actually prompted me to make this post so I could share it :laughing:.

![Filelight](/images/posts/disk-usage-in-linux/filelight.png)
