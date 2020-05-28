---
title: "A Word On Documentation and Static Site Generators"
date: 2020-04-07T22:08:26-04:00
draft: false
toc: false
images:
tags: 
  - docs
  - documentation
  - ssg
  - "static site generator"
---

It is incredibly important to document your code.
Not only does it help your future self understand, but it also helps others find their
way around.

This post will be talking about some of the tools developers can use to generate docs
for their projects.

## The Premise Is Simple

There are many tools out there that allow you to create, organize, and serve documentation,
but they are all more or less based around the same concept, which is this:

Take some text written in Markdown, reStructuredText, or some other "plain text" format as input
and output a static site composed of HTML, CSS, and JS.

Chances are there is a Static Site Generator for any language you are using, so
just give it a search!

## Blogs and Docs

Static Site Generators (SSGs) that are very well equipped for creating blogs, landing pages and docs.
You would be hard pressed to find a project out there that does not use some type of site generator to create
their documentation.

In the JavaScript ecosystem, there are many great SSGs like [Gatsby](https://www.gatsbyjs.org/),
[Next.js](https://nextjs.org/), [VuePress](https://vuepress.vuejs.org/), and [Hexo](https://hexo.io/)

[Jekyll](https://jekyllrb.com/) is a static site generator that has been around for a while.
It is written in Ruby and has a great community and is a more mature and stable project.

The SSG that i'm using to create this blog is [Hugo](https://gohugo.io/), which
is written in Go, but has a very powerful templating language, content organization,
and many other features that are great if you need them.

The reason I mention these tools with their language is because often times the "flavor"
of html templating depends on what the templating is like for the language of the tool.

For example, Hugo uses Go's buliltin [text templates](https://golang.org/pkg/text/template/),
Jekyll uses [Liquid](https://jekyllrb.com/docs/liquid/), and pretty much all the
Python site generators use [Jinja](https://jinja.palletsprojects.com/)

Python has some static site generators that are specifically tailored to creating
documentation of all kinds. These may not have all the neat bells and whistles of
the tools above, but they make up for that with their simplicity and ease of use.

## Docs

There is the ubiquitous [Sphinx](https://www.sphinx-doc.org/en/master/examples.html), which
seems to be the defacto documentation generator as far as I can tell.
It uses reStrutcturedText by default, but can be configured to use markdown if you're into that.

An alternative that supports markdown by default is [MkDocs](https://www.mkdocs.org/) and it
is equally supported.

Of course you cannot mention Sphinx and MkDocs without mentioning [Read The Docs](https://readthedocs.org/),
which will look for your documentation in a project's repo, generate it, and host it for you.

This is an awesome way to host ad-hoc documentation for a project for free, and not much effort.

## Too many choices

Yes there are more of them out there than you can shake a stick at, and they all come with
their own special quirks and caveats that can only be found by usage. If there is no killer feature
that you really need for a site, I would recommend just picking based on the categories you need the most,
like what features do you need, do you like the themes, what's the community like, and is the templating
powerful enough, etc,.

## Don't forget what you came here for

Also as an ending note, I will say that it is easy to get caught up searching and comparing
features of tools that all do the same thing at their core. Even for something as simple as
generating static html, there are thousands of different tools out there with slight variations.

I'm not knocking static site generators, because it is a similar story for 
web frameworks (frontend and backend), CMS, or any technology where there are many viable alternatives.
It might be fun to try out a few, but when it comes time to pick one, make sure it suits YOUR needs
and that you don't get "ooh'ed and ahh'ed" by features that you don't need.

For some tools, the best feature is simplicity.
