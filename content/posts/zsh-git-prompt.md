---
title: "Zsh Git Prompt"
date: 2022-08-11T23:22:10-04:00
draft: false
toc: false
images:
tags:
  - zsh
  - shell
  - git
  - prompt
---

## My ZSH Git Prompt

`zsh` is a great interactive prompt, however it can be a little tough to find
solutions that do not rely on plugins or plugin managers like `oh-my-zsh`.

If you are looking for a portable zsh function for getting git status in
your zsh prompt, here is what I am using currently (adapted from my bash git prompt):

{{< gist lemonase c034f055c7f5aef24f05b052c2253189 ".zshrc" >}}

This function gets the git status and branch - greps out a few keywords that
I'm interested in and prints out some characters accordingly.

I like this because solution because it is simple and it provides a really good
way to see the state of a repo at a glance.

I'm sure there are other ways to do this as well - you can extract way more detailed
information from git, but this is good enough for my use cases.

Cheers!
