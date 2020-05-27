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

Checking on disk usage of mounted partitions in linux is easy, it is actually one command.

```shell
df -h
```

The `-h` makes the output human readable (think MB, GB instead of bytes or kilobytes)

## Disk usage by directory

The command used to check disk usage of directories on Linux is `du` and it is fairly fast and easy to work with.

Note the regular output is in kilobytes, but like many other utils, adding `-h` will make the results human readable.

Also the default behaviour is to recursively go through all the files in the directories provided (or the current directory).
It is similar to `ls -R` or `find` in that way.

Adding a `-s` will "summarize" the output instead of recursing into the directories provided. There is also a `-c` option
to give a total at the end.

The command I use all the time to quickly see what is taking up the most space is just

```shell
du -shc * | sort -hr
```

## Graphical tools

There are all kinds of awesome scripts and programs that people have written to visualize disk usage in creative ways.

There are other tools like `ncdu` to `duc` which provide an alternative way to see disk usage with a curses like interface.

Recently I found one installed on my system with KDE is called `Filelight` which lays out files in a cool pie chart.
It was so cool that it actually prompted me to make this post so I could share it :laughing:.

![Filelight](/images/posts/disk-usage-in-linux/filelight.png)
