---
title: "Changing Hugo Themes"
date: 2022-11-23T11:42:32-05:00
draft: false
tags: ["hugo", "theme", "content management"]
---

## Revisiting Hugo Themes :heart:

I started using Hugo in 2019 and have stuck with the same theme for my blog for
the most of that time... until now.

I ended up on [Blowfish](https://github.com/nunocoracao/blowfish) mostly because
the flexibility of layouts and feature set was exactly what I was looking for in
a theme.

## Hugo Learnings

I also learned some things about Hugo content organization, changing Site params
in frontmatter and a directory based config approach (compared to a single file).


### Content Organization

In the root of a hugo site, there will 99% of the time be a `content` directory
to keep markdown files, **but** you are not limited to only markdown files. You
can really put any file there with a valid mimetype.

Browsing the blowfish `exampleSite` code, I saw that each post or article lived in a
article named directory with an `index.md` file for the content and a `featured.png` to
be shown in the "Hero Section" of the article (or in the background if that is set).

```text
$ tree themes/blowfish/exampleSite/content/docs/
...
themes/blowfish/exampleSite/content/docs/homepage-layout/
├── featured.png
├── home-background.png
├── home-card.png
├── home-hero.png
├── home-list.png
├── home-page.png
├── home-profile.png
└── index.md
```

This is a departure from the way I was doing images before, which involved storing
pictures in `/assets/` and then referencing the path either in the frontmatter or within
the post itself.

In all honesty, I prefer the new way of keeping a self-contained [Page Bundles](https://gohugo.io/content-management/organization/#page-bundles) with all the assets
it needs in one directory - so I will likely start doing that for new posts.

## Setting .Site.Params in frontmatter

This is one thing that I knew was possible but I struggled for a little bit to
find the exact way to override values set in params.

It turns out there is a `cascade:` config key that lets you do this from any resource that has frontmatter.
[docs for cascade:](https://gohugo.io/content-management/front-matter/#front-matter-cascade)

For example in my `posts/_index.md`, I have the following:

```yml
---
title: "Posts"
date: 2022-06-13T20:55:37+01:00
draft: false

cascade:
  showDate: true
  showTaxonomies: true
  showWordCount: true
---
```

This way, all the content in and under `posts` will have these params set. You can also
do this with individual posts, say if you want a different layout from the global config.
