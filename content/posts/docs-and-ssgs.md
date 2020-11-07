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
  - hugo
  - jekyll
---

Documenting your code is incredibly important.
Not only does it help your future self understand, but it also helps others find their
way around.

This post will be talking about some of the tools developers can use to generate docs
for their projects.

## The Premise Is Simple

There are a plethora of tools out there that allow you to create, organize, and serve documentation,
but they are all more or less based around the same core concept, which is this:

Take as input some text written in Markdown, reStructuredText, or some other "plain text" format
and output a static site composed of HTML, CSS, and JS.

Chances are there is a Static Site Generator built with the language you are using, so give it a search!

## Use Cases

Static Site Generators (SSGs) are well equipped for creating blogs, landing pages and docs.
You would be hard pressed to find a project out there that does not use _some_ variation of
a site generator to create their documentation.

## SSG Rundown

In the JavaScript ecosystem, there are tons of great SSGs like [Gatsby](https://www.gatsbyjs.org/),
[Next.js](https://nextjs.org/), [VuePress](https://vuepress.vuejs.org/), and [Hexo](https://hexo.io/).

[Jekyll](https://jekyllrb.com/) is a static site generator written in Ruby that has been around since the early 2010's.
Jekyll is a solid choice due to it's maturity, support, and wide acceptance from Github Pages.

The SSG that I'm using to create this blog is [Hugo](https://gohugo.io/), which
is a project written in Go. It features a powerful templating language, content organization,
and other integrations and conveniences that are great if you need them.

The reason I mention these tools with their language is because often times the "flavor"
of html templating depends on what the templating is like for the language of the tool.
It's also important if you ever wish to make a theme, or a plugin or something of that matter.

For example, Hugo uses Go's buliltin [text templates](https://golang.org/pkg/text/template/),
Jekyll uses [Liquid](https://jekyllrb.com/docs/liquid/), and pretty much all the
Python site generators use [Jinja](https://jinja.palletsprojects.com/)

Python has some static site generators that are specifically tailored to creating
documentation of all kinds. These may not have all the neat bells and whistles of
the tools above, but they make up for that with their simplicity and ease of use.

## Docs Specifically

The ubiquitous [Sphinx](https://www.sphinx-doc.org/en/master/examples.html),
seems to be the defacto documentation generator for Python as far as I can tell.
It uses reStrutcturedText by default, but with configuration, it can use markdown if you're into that.
An alternative that supports markdown by default is [MkDocs](https://www.mkdocs.org/) and is well supported.

Of course you cannot mention Sphinx and MkDocs without mentioning [Read The Docs](https://readthedocs.org/),
which will look for your documentation in a project's repo, generate it, and host it for you.
This is an awesome way to host ad-hoc documentation for a project for free, and not much effort.

Another comprehensive solution to docs that has taken prominence in the Rust ecosystem is [mdBook](https://github.com/rust-lang/mdBook)
which I haven't looked at in much detail, but it looks clean and promising.

## Too Many Choices

Yes there are more of them out there than you can shake a stick at, and they all come with
their own special quirks and caveats along with the features and themes. If there is no killer feature
that you _need_ for a site, I would recommend asking what is most important to you -
like what features are important, speed? plugins?, do you like the themes, what's the community like, is it maintained?
is the templating powerful enough?, etc,.

## Lessons

As an ending note, I will say that an easy trap to get caught in is endlessly
searching and comparing tools that essentially do the same thing at their core.

That's kind of what I did, and why I wrote this blog post.

Even for something as simple as generating static html,
thousands of different projects exist out there with slight variations and nuances.
Picking one can be hard, but this can be true of any software where there are lots alternatives and functionality overlaps.

I wouldn't necessarily say that it's a bad thing that this happens, but learning to navigate through a sea of software to find
the right tools can be a skill in and of itself.
