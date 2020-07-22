---
title: "Finding Files on Linux"
date: 2020-07-21T23:41:00-04:00
draft: false
toc: false
images:
tags:
  - find
  - ls
  - files
  - directories
  - fzf
---

## Find with `find`

The `find` command is a pretty basic utility, but it does have loads of options, which
may be intimidating at first, but keep in mind it has about every criteria you would
possibly need when searching for attributes of files or directories.

It is also the standard way to search files/directories by criteria like name,
date created, size, permissions, user, and more.

The syntax and options may seem irregular compared to other commands,
but I'll show a few examples:

### Examples

List every file and directory recursively under the current directory

```sh
find .
```

Find **files** under current directory with the name foo

```sh
find . -type f -name 'foo'
```

Find files under /etc/ with the (case-insensitive) pattern _bash_ somewhere in the filename

```sh
sudo find /etc/ -type f -iname "*bash*"
```

Find files in home directory that have been modified in the last 24 hours
(Piping commands that produce lots of output to a pager program like `less` can
speed up output significantly)

```sh
find $HOME -type f -mtime 0 | less
```

Execute the `file` command on every file under current directory and format
the output into a table

```sh
find . -type f -exec file '{}' \; | column -t -s ":"
```

Find directories under /etc/ where cron is in the name

```sh
sudo find /etc/ -type d -iname '*cron*'
```

`find` has lots of options to filter by every file attribute available.
But in the majority of cases, we're interested in finding
something by **filename**, even using **fuzzy pattern matching** or
the universal `grep` to get what we're looking for from lots of output.

It may be worth it to check out newer tools such as
`fzf` ["the fuzzy finder"](https://github.com/junegunn/fzf), which takes
advantage of all the functionality of find, but is more interactive and gives
instant visual feedback when filtering files -- or any text for that matter.
This frees you from doing "manual" regex pattern matching for the name of a file.

It also uses stdin and stdout, so it plays nice with other commands

### Examples

Find recently modified files, filter them with fzf and send selected file(s) to stdout

```sh
find . -type f -mtime 0 | fzf
```

Use command substitution to open a file selected with fzf with vim

```sh
vim $(fzf)
```

Of course the big caveat with these extra utilities is that they are almost guaranteed
to **not** be on any machine by default, which is a big thing for POSIX people who
like to stick to standard tools.

These days the process of installing stuff is easier
than ever with git, docker images and package managers.
There is really no harm in giving these things a try.

In some extreme cases, `find` may not even be on some machines,
but that doesn't mean you can't search for files with other tools.

## Find without `find`

### Step 1

Run any command that recursively lists all files and directories.
These include but are not limited to:

- `ls -R`
- `du`
- `tree`

Also `ls` has some filtering/sorting capabilities for file and directory
attributes. Using flags like `--directory`, `--file-type`, `--sort=`,
`--time=`, but it not as featured as `find` when it comes to pruning/filtering
output, and the main purpose is just to list directories,
so you will have to use other filters to trim down results.

### Step 2

Pipe output to `grep` or `less`

### Examples

Finding my_file with `ls`

```sh
ls -R | grep my_file
```

Finding my_file with `du`

```sh
du | grep my_file
```

Getting a full tree view of all directories with `tree`

```sh
tree | less -R
```

The `-R` option tells less to interpret ANSI color codes.
