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

## Shell

### Getting the current working directory

The environment variable `$PWD` and the command `pwd` are essentially synonymous.
`pwd` has flags for dealing with symlinks.

### Absolute (canonical) path

- `realpath` - Turns relative paths into absolute paths
- `readlink -f` - Originally meant to read symlinks. The `-f` flag means give "cannonical" path.

### Elements of a directory

- `dirname` - Strips the rightmost part from a given directory.
- `basename` - Strips all base directories, leaving the last (rightmost) part of a path/file

NOTE: These commands do not check if a file/directory actually exists, they just
manipulate path strings. Also, be careful when dealing with symbolic links and
read the man page to get the desired behavior.

## Python

## Using the os module

```python3
import os
```

### Current working directory

```python3
os.getcwd()
```

### Absolute (cannonical) path

```python3
os.path.abspath("blog")
```

### Elements of a directory

```python3
os.path.dirname("blog")
os.path.basename("blog")
```

## Pathlib

As of Python 3.4 here is a module called [`pathlib`](https://docs.python.org/3/library/pathlib.html#module-pathlib),
which provides a more OOP style of
interacting with files.

[`os` and `pathlib` have lots of overlap](https://docs.python.org/3/library/pathlib.html#correspondence-to-tools-in-the-os-module)
but the module provides extra methods for file globbing, pattern matching
does a better job of integrating "system paths" into the language IMO.

This module converts paths from strings
into higher level "file objects". This is something that the `os` module does
not do -- and perhaps you don't need this extra encapsulation.

If you ever find yourself importing `re` or `shutil` to deal with files and paths
in Python, it might be worth it to try out `pathlib`.

I'll give some example usage:

```python3
from pathlib import Path

# get (absolute) current directory
wd = Path.cwd()

# the resolve method converts any
# relative into an absolute path
wd = Path('.').resolve()

# adding subdirectories
# instead of using os.path.join()
# you can simply use the / operator
n = wd / 'content'

# print basename and dirname
print(wd.parent, wd.name)

# recursively globbing filenames
# from a relative path
for f in wd.glob('**/*.html'):
  print(f)

list(wd.rglob('*.html'))
```
