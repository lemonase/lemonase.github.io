# My personal blog and portfolio @ [lemonase.github.io](https://lemonase.github.io)

I am currently using [Hugo](https://gohugo.io/) to generate the static (HTML/CSS/JS) portion site and
[Blowfish](https://github.com/nunocoracao/blowfish/) as my theme...

Many thanks to the maintainers of these projects!

## Working Locally with Hugo

## running hugo dev server (watching for file changes and drafts)

```sh
hugo serve -D
```

## Creating new pages

```sh
# create a new post
hugo new posts/{post_name}/index.md

# create a new project page
hugo new projects/{project_name}/index.md

# create a new website showcase page
hugo new websites/{website_name}/index.md
```

## Updating git submodules (for themes)

Note: Git submodules **do not** get initialized or updated automatically upon cloning/pulling!

To init/update submodules after cloning:

```sh
git submodule init

git submodule update --recursive --remote --merge
```

## Deploying

### Hosting

- [Github Pages](https://docs.github.com/en/pages)

### Building and Deploying Hugo

- [Github Actions](https://docs.github.com/en/actions)
- [Hugo Github Action](https://github.com/peaceiris/actions-hugo)

### Using a custom domain

- [Github Pages - Setting up custom domain](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/managing-a-custom-domain-for-your-github-pages-site)
