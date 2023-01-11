---
title: "Adding Github (SSH and PAT) Credentials On Linux and macOS"
date: 2022-12-01T11:43:48-05:00
draft: false
tags:
  - git
  - github
  - macos
  - linux
  - pat
  - ssh
  - auth
---

This post is going to be a very short guide on creating/adding a PAT (personal access token)
or SSH key on [GitHub](https://github.com) and adding it to a Linux (or Mac) host.

This is necessary because GitHub has [deprecated password authentication as of
August 13, 2021](https://github.blog/changelog/2021-08-12-git-password-authentication-is-shutting-down/)

This means all authentication on the platform can only be done two ways:

1. [SSH/GPG Keys](https://github.com/settings/keys)
1. [PAT Tokens](https://github.com/settings/tokens)

## Generating SSH Keys

Follow [this guide](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
to create ssh keys with `ssh-keygen`.

After that, you should have a public ssh key somewhere in your `~/.ssh/` directory.

In GitHub settings go under "SSH and GPG keys" -> "SSH Keys" -> "New SSH key".

Now you can take that public key you just generated (`id_rsa.pub` by default)
and copy paste the contents into key section on GitHub - don't forget to give
it a descriptive title, hit "Add SSH key" and that's it!

From here, you just have to remember to use SSH instead of HTTPS when cloning,
pulling or pushing repos.

Example:

```sh
# do this
git clone git@github.com:lemonase/dotfiles.git

# instead of this
git clone https://github.com/lemonase/dotfiles.git
```

If you do want to continue to use HTTPS, you will need to generate a PAT on GitHub.

## Generating a GitHub PAT (Personal Access Token)

Visit this link to get a guide on creating a PAT from your GitHub account.

Guide:
<https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token>

Direct Link:
<https://github.com/settings/tokens>

After the token is created with all the permissions desired (you probably want read/write acces to repos), go ahead and copy
that sucker straight to your clipboard (seriously, it will disappear).

Also Note: This token is the equivalent to your GitHub password, so be careful and don't hand it out to strangers!

## Storing git credentials

By default, git credentials can be stored in `~/.git-credentials` or `$XDG_CONFIG_HOME/git/credentials`

The schema to use in this file is as follows:

```txt
https://<github_username>:<github_pat_token>@github.com
```

### Note

There are several other more secure ways to store or input git credentials temporarily, such
as `git-credential-cache`, which will put your credentials in memory for a set
amount of time.

## Man Pages

See [`man gitcredentials`](https://man7.org/linux/man-pages/man7/gitcredentials.7.html) for more info on ways to handle passing credentials to git.
See [`man git-credential-store`](https://man7.org/linux/man-pages/man1/git-credential-store.1.html) for more info on storing git credentials.
See [`man git-credential-cache`](https://man7.org/linux/man-pages/man1/git-credential-cache.1.html) for more info on caching git credentials.
