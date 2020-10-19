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

## Getting the current directory

The environment variable and the command are synonymous. `pwd` has flags for
dealing with symlinks.

- `$PWD`
- `pwd`

## Getting elements from a directory string

- `dirname NAME`

  - Strips the last part from a directory

- `basename NAME`

  - Strips the beginning directory, leaving the last part

## Getting absolute (canonical) directory

- `realpath`

  - Turns relative paths into absolute paths

- `readlink -f`

  - Older version of `realpath`

NOTE: These tools have options for different behaviours when working with
symlinks
