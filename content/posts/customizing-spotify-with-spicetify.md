---
title: "Customizing Spotify With Spicetify"
date: 2021-02-11T16:29:58-05:00
draft: false
toc: false
images:
tags:
  - themes
  - css
  - spotify
---

I recently learned about a project called [spicetify](https://github.com/khanhas/spicetify-cli)
that allows you to customize the theme of your Spotify client and I thought
I would share.

[Installing it](https://github.com/khanhas/spicetify-cli/wiki/Installation)
is a few commands on all platforms and people have already made tons of
themes and extensions.

### Example

This is what my Spotify looks like with the "Spicy" theme:

![theme_pic](/images/posts/spicetify/spicetify.png)

## Configuration

Customizations are stored in a config file located at:

- Windows: `%USERPROFILE%\.spicetify\config.ini`
- Linux: `~/.config/spicetify/config.ini`
- MacOS: `~/spicetify_data/config.ini`

## Themes

To get themes, you can clone the [community themes repo](https://github.com/morpheusthewhite/spicetify-themes)
and copy them to these directories

- Windows: `%USERPROFILE%\.spicetify\Themes\`
- Linux: `~/.config/spicetify/Themes`
- MacOS: `~/spicetify_data/Themes`

## Extensions

Spicetify even has [extensions](https://github.com/khanhas/spicetify-cli/wiki/Extensions)
that people have written to improve the spotify experience.
These are enabled by editing the config file (just like themes).

One of the main ones that I appreciate is the "[Shuffle+](https://github.com/khanhas/spicetify-cli/wiki/Extensions#trash-bin)"
extension, which allows you to reshuffle the contents of a queue in a fashion
that is more random.
I also really like the idea of the "[Trashbin](https://github.com/khanhas/spicetify-cli/wiki/Extensions#trash-bin)"
extensions where you can pick
songs that you never want to hear ever again.

If you feel like the plain old spotify client is lacking in features or UX/UI,
I highly recommend checking out spicetify.
