# My personal blog and portfolio @ [lemonase.github.io](https://lemonase.github.io)

I am currently using [Hugo](https://gohugo.io/) to generate the static (HTML/CSS/JS) portion site and
[Blowfish](https://github.com/nunocoracao/blowfish/) as my theme...

Many thanks to the maintainers of these projects!

## Hugo Commands

## running hugo dev server (watching for file changes and drafts)

```sh
hugo serve -D
```

## creating new pages

```sh
# create a new post
hugo new posts/{post_name}/index.md

# create a new project page
hugo new projects/{project_name}/index.md

# create a new website showcase page
hugo new websites/{website_name}/index.md
```

## updating git submodules (for themes)

Note: Git submodules **do not** get initialized or updated automatically upon cloning/pulling!

To init/update submodules after cloning:

```sh
git submodule init

git submodule update --recursive --remote --merge
```

## deploying

Here is just a quick rundown of how and where I deploy my site.

I have a small [DigitalOcean Droplet VPS](https://www.digitalocean.com/products/droplets) running
[nginx](https://www.nginx.com/) (for servering) and [certbot](https://certbot.eff.org/) (for certs). Digital Ocean Referral Link below!

There is a `deploy.sh` script which is just a wrapper around running `hugo && rsync user@server:/var/www/html`. I have a [git hook](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks) that runs this script on every `git push`.

And that is the whole process.

I do not currently use any CI/CD solutions, app platforms or containerization as of now for a few reasons:

1. small static site (can be served anywhere for cheap)
2. i don't mind managing my VPS and nginx (compared to something like docker compose)
3. it works

Maybe sometime in the future, I will containerize everything make a blog post about it... :)

Thank you for reading!

[![DigitalOcean Referral Badge](https://web-platforms.sfo2.digitaloceanspaces.com/WWW/Badge%203.svg)](https://www.digitalocean.com/?refcode=1f0004d6e4a6&utm_campaign=Referral_Invite&utm_medium=Referral_Program&utm_source=badge)
