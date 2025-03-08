---
title: "Migrate Your Repos From Github To Gitea+"
date: 2025-03-07T18:29:34-05:00
draft: false
tags:
  - git
  - self-hosting
  - repo
  - management
---

Hello, it is me again. Here today talking about getting repos *off* of GitHub
and taking them elsewhere.

Any one of the great alternatives that exist out there like 
{GitLab, Gitea, Gogs, Bitbucket}.

In my particular case - I am messing around with self-hosting a [Gitea](https://docs.gitea.com/)
instance, so that will be the focus here.

## Setup

First thing, we will need to get access to the GitHub cli tool `gh`.

- [Install it](https://github.com/cli/cli?tab=readme-ov-file#installation)
- [Authorize with `gh auth login`](https://cli.github.com/manual/gh_auth_login)

and you are off to the races.

## A Script

```bash
#!/bin/bash
#
# Script to pull all Github Repos and rsync to destination
#

REPO_ROOT="$HOME/gh-repos"
DEST_ROOT="$HOME/docker/gitea/data/git/repositories/jam"

# make repo root
[ ! -d "$REPO_ROOT" ] && mkdir "$REPO_ROOT"
cd "$REPO_ROOT"

# clone all repos listed with gh cli
for repo in $(gh repo list -L 100 | awk '{print $1}'); do
  [ ! -d "$(basename $repo)" ] && gh repo clone $repo
done

# pull and rsync to destination (gitea in this case)
for d in "$REPO_ROOT/"*; do
  if [ -d "$d" ]; then
    echo "[git pull && rsync] repo: $d"
    pushd $d > /dev/null
    git pull && rsync -avz ".git/" "$DEST_ROOT/$(basename $d).git/"
    popd > /dev/null
  fi  
done
```

This script will clone and pull all repos from GitHub into `$REPO_ROOT`
and it will rsync the `.git` folder of these repos to `$DEST_ROOT`
(this is the location that my Gitea docker instance is configured to look for repositories).

After this, you may need to [adopt your repos](https://forum.gitea.com/t/how-to-add-existing-repository-to-gitea-from-filesystem/4671)
in Gitea, which is a simple process of hitting a button in the UI.
One thing to note is the process of importing repos from local filesystem
may differ on other git hosts.

As always happy hosting and happy hacking!

