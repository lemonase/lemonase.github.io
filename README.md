# My personal blog @ [jamesdixon.dev](https://jamesdixon.dev)

I am currently using [Hugo](https://gohugo.io/) to generate the static (HTML/CSS/JS) portion site and
[Blowfish](https://github.com/nunocoracao/blowfish/) as my theme...

Many thanks to the maintainers of these projects!

## hugo commands

common hugo commands

## running hugo dev server (watching for file changes and drafts)

```sh
hugo serve -D
```

## creating a new post

```sh
hugo new posts/{post_name.md}
```

## creating a new project

```sh
hugo new projects/{project_name.md}
```

## creating a new website (website showcase)

```sh
hugo new websites/{website_name.md}
```

## updating submodules for themes

Note: Git submodules **do not** get initialized or updated automatically upon cloning/pulling!

To init submodules after cloning:

```sh
git submodule init
```

To update all submodules, run:

```sh
git submodule update --recursive --remote --merge
```

## deploying

Here is just a quick rundown of how and where I deploy my site.

I have a small [DigitalOcean Droplet VPS](https://www.digitalocean.com/products/droplets) running
[nginx](https://www.nginx.com/) (for servering) and [certbot](https://certbot.eff.org/) (for certs).

There is a `deploy.sh` script which is just a wrapper around running `hugo && rsync user@server:/var/www/html`. I have a [git hook](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks) that runs this script on every `git push`.

And that is the whole process.

I do not currently use any CI/CD solutions, app platforms or containerization as of now for a few reasons:

1. small static site (can be served anywhere for cheap)
2. i don't mind managing my VPS and nginx (compared to something like docker compose)
3. it works

Maybe sometime in the future, I will containerize everything make a blog post about it... :)

Thank you for reading!
