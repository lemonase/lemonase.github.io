# This is the repo for my [personal blog](https://www.jamesdixon.dev)

I use [Hugo](https://gohugo.io/) to generate the site and manage content.
I also use a slightly customized version of the [Hermit](https://github.com/Track3/hermit) theme.

## creating a new post

```sh
$ hugo new posts/{post_name.md}
```

## updating submodules

To init submodules after cloning:

```sh
$ git submodule init
```

To update all submodules, run:

```sh
$ git submodule update --recursive --remote --merge
```

