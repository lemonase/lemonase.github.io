---
title: "Locating Commands"
date: 2020-10-09T21:40:26-04:00
draft: false
toc: false
images:
tags:
  - cli
  - linux
  - windows
  - bash
  - cmd
  - powershell
---

## Getting the location of commands in Unix

### Unix Shells

AFAIK, there are four ways to find out where a command is in your path.

#### Shell Builtins

- `command -v` (POSIX shell way)

  - Shows the command that would be run by your shell (without actually running it)

- `type [-afptP]` (bash builtin way)

  - Essentially the same function as `command`, but with more options

Both `command` and `type` can output the location of any **executable**,
**script**, **alias**, or **shell builtin** in your \$PATH and your shell
environment.

#### System Executables

Found in `/bin/`, `/usr/bin/`, or `/usr/local/bin/`

- `which`

  - **Exclusively** searches for executables/scripts in \$PATH (unless provided
    extra options)

- `whereis`

  - Same function as `which`. Can also show location of the man pages

I find using `command -v` is a common way to check if a command exists
in shell scripts, while `type -a` is handy for occasions when I'm unsure if
something is a shell function/alias and `which` if I'm sure it is in \$PATH.

Specifically, finding what type of file a command is using `file $(which COMMAND)`

## Getting the location of commands in Windows/DOS

### `cmd.exe`

In `cmd`, there is one way to find the location of a given command:

- `where.exe`
  - Finds executables in %PATH% or the current directory

### PowerShell

`where.exe` can still be called in PowerShell, but there is also a cmdlet
available to get PowerShell commands and executables.

- `Get-Command`
  - alias: `gcm`

## Reasons

### Security

There are all kinds of security reasons to double check that the commands run
in a shell are in the right spot. Supposing somebody gained user access on your
machine, they could modify your .bashrc and your \$PATH to run any program with
`ls` without you ever knowing until it's too late.

### Duplicate Programs

There are circumstances when there are multiple programs of the same name in
\$PATH.

### Getting Bearings

Although the FHS standard exists and is mostly conformed to, there are near
infinite ways to layout a Linux file system. Executables can be **anywhere**.
On Windows, the %PATH% variable is still important for doing command line stuff,
but most of the time programs are launched from Explorer, and the complexity
of "which program do I use to open a file" is stored in the Registry or in
context menus and can be edited accordingly.
