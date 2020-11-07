---
title: "Working With Absolute and Relative Paths"
date: 2020-10-10T01:26:21-04:00
draft: false
toc: false
images:
tags:
  - paths
  - directories
  - linux
  - shell
---

![Path](/images/posts/paths/path.jpg)
> <a href="https://commons.wikimedia.org/wiki/File:Forest_path_and_trees.jpg">Denis Zastanceanu</a>, <a href="https://creativecommons.org/licenses/by-sa/4.0">CC BY-SA 4.0</a>, via Wikimedia Commons

## Getting the current directory

The environment variable `$PWD` and the command `pwd` are essentially synonymous.
`pwd` has flags for dealing with symlinks.

## Getting absolute (canonical) path

- `realpath`

  - Turns relative paths into absolute paths

- `readlink -f`

  - Older version of `realpath`

## Getting elements of a directory

- `dirname NAME`

  - Strips the rightmost path from a given directory

- `basename NAME`

  - Strips all base directories, leaving the last(rightmost) path/file

NOTE: These commands do not check if a file/directory actually exists, they just
manipulate path strings. Also, be careful when dealing with symbolic links and
read the man page to get the desired behavior.
