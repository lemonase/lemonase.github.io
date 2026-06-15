---
title: "jj: Git/Monorepo Compatible Version Control"
date: 2026-05-26T12:38:09-04:00
draft: false
---

Recently a few *newer* projects have come to my attention surrounding *version
control* tools. I have been a little bit curious and somewhat skeptical about
trying them out.

Just to get potential bias out of the way - I do work at Google (currently as
Hardware Operations - with a sprinkle of software development / software
engineering), so if that sways my opinions down below, I would rather say it
here before going further.

## Sapling

[Sapling](https://sapling-scm.com/) is version control that is "git compatible"
coming from Meta (Facebook) open source. I have to imagine I might be more
compelled to look into this project if I worked at Meta and had to work with
their monorepo instead of Google's.

## Jujutsu (jj)

[Jujutsu](https://github.com/jj-vcs/jj) is a side project that comes from
Googler Martin von Zweigbergk and I have heard of mostly from other Googlers,
not as much from the open source community.

The main appeal seems to be some nice quality-of-life features that it layers
on top of existing version control systems (like git and Mercurial/Piper and
for the monorepo at Google).

### The Experiment

Naturally I wanted to give it a try to see how it stacks up to git. Admittedly
I am not much of a git power user, but I am familiar and comfortable with basic
operations on my repos like branching, merging and of course committing code.
I mostly use git from the CLI as well.

I want to see if Jujutsu has anything to offer for a basic/intermediate git
user such as myself (I occasionally push code to the monorepo at work as well).

I will be trying it out and report back my thoughts and findings - either
amending this post or in a new one.

Until next time!

### Update 06-16-26 (a few weeks later)

`jj` is good and I think improves on many things from `git`. In particular, I think
the configuration/CLI ergonomics work better than git for me personally. Having
subcommands like `jj fix` and `jj config edit --user` are really good and it
just makes sense in my mind. Having a configurable default command makes sense.

The thing that I struggle with is the concept of `revset` and the mini language
used to represent them [revest docs](https://www.jj-vcs.dev/latest/revsets/).

I know the basics, however I am still having to resort to the docs to find out
how to do things that I know how to do in Git. There is a helpful [command
table](https://www.jj-vcs.dev/latest/git-command-table/) to help with that
as well.

Happy hacking!


