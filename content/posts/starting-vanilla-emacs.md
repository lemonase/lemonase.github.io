---
title: "Starting Vanilla Emacs"
date: 2025-03-20T15:53:13-04:00
draft: false
tags:
  - emacs
  - gnu
  - linux
  - editor
---

A few days ago, in an kind of curious mood, I decided it would be a good time to give
Emacs (and key-binds) another try for no reason in particular. I already use the
`readline` key-binds in the shell, so I'm almost like half-way there or something, right?

## Previous Attempt Using Vanilla Emacs

I had tried using vanilla Emacs before and the defaults were just bad enough to keep
me away.

Particularly the key-binds / key chords were just too much for me to deal with, so I tried
[EVIL](https://github.com/emacs-evil/evil) mode early on and was simultaneously impressed 
that it worked so well, but also frustrated by the things that were not
coherent/consistent across the various awesome packages and plugins I had installed.

These days, that seems to be better handled as EVIL mode and Emacs have both improved
and it seems like the community has mostly figured it out. The experience was tiring
though, and left me not really trusting *any* of the key-binds. I just did not understand Emacs
Lisp enough to adapt all the key-binds to do the things that I really wanted them
to do.

Eventually I stopped using Emacs and went back to using VS Code or Vim at the time,
just to get work done, but the experience had stuck with me for sure and I knew
in the back of my mind that I would come back one day and that the experience
I has was not `*scratch*`

## Experience / Lessons / Hindsight

Here are some things that I did not fully understand and confused me about Emacs.

### Emacs Lisp is #1 Feature of Emacs

In my first attempt, I did not really have the time or patience to dive into Lisp
in a way that would unlock more in-depth configuration options.

I acknowledged the extremely efficient, tailored and clean workflows
that Emacs (and package ecosystem) excels at, but I was not ready to take
the first step by learning elisp.

### No Obligation to Respect Default Key-binds

Normally, I am someone who likes to keep shortcuts and system wide key-maps default
so that becomes really limiting in regards to Emacs, which makes excessive use of
Control (`C`), Alt (`M`), and Win/Super (`S`) keys and contents for some of the
same keyboard keys used by the OS / Window Manager.

So the wonky ergonomic situation of the `<Control>` key and left pinkie is not great
and will likely lead to RSI, but it can be mitigated. I still prefer `hjkl` vim keys
for navigation, but `C-p` and `C-n` for previous and next are nice as well.

This time around, I think I will be more aggressive in rebinding the keys to do
the things that I need them to do.

## A New Buffer: Where We Are Today

So given the previous experience with Emacs, I knew more of what I was getting into
and could prepare for what I need in order to be effective and use in a way where
I can leverage elisp and the packages that exist.

It has only been a few days, but I believe I am starting to come to a configuration
that is tolerable for everyday editing for text, scripts and markdown. I have not done
any major-mode programming yet so I can't extrapolate there quite yet.

I am thankful to all the folks online who contribute to the forums, discussion and
threads about Emacs and all the developers who are responsible for making Emacs great
or at least no-so-bad.

I am finding there are more things to like about Emacs now more than ever.

Here is my `init.el` I have been rocking:

https://github.com/lemonase/dotfiles/blob/master/config/emacs/.config/emacs/init.el

In traditional fashion, my config is cobbled together from various posts from
stack overflow, forums and github projects. This is the way.

I did want to leave links to some of the resources that have helped me out.

### Helpful Stuff

I can shout out a few docs and posts that have really made the process of setting
up packages and learning elisp a much better experience for a n00b such as myself.

- [jamescherti/minimal-emacs.d](https://github.com/jamescherti/minimal-emacs.d)
> The minimal-emacs.d project is a lightweight, bloat-free Emacs base (init.el and early-init.el) that gives you full control over your configuration (without the complexity of, for instance, Doom Emacs or Spacemacs). It provides better defaults, an optimized startup, and a clean foundation for building your own vanilla Emacs setup.

#### Learning Emacs Lisp

- [GNU: Intro to Programming In Emacs Lisp](https://www.gnu.org/software/emacs/manual/html_node/eintr/index.html)
- [Learn (elisp) in (y) minutes](https://learnxinyminutes.com/elisp/)


There is still so much to learn and get accustomed to. Things like:

- [Org Mode](https://orgmode.org/index.html)
- [Dired](https://www.gnu.org/software/emacs/manual/html_node/emacs/Dired.html)
- [Magit](https://magit.vc/)
- [TreeSitter](https://www.masteringemacs.org/article/how-to-get-started-tree-sitter)
- [LSP w/ Eglot](https://github.com/joaotavora/eglot)
- [gptel (LLM)](https://github.com/karthink/gptel)

