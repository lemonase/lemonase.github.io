---
title: "Strudel :: A REPL for Music Production"
date: 2025-12-06T12:43:05-05:00
draft: false
tags:
  - music
  - production
  - art
  - coding
  - repl
  - javascript
  - strudel
---

## Strudel REPL

Hello, I wanted to share a really neat project that I stumbled upon recently -
it is called [*strudel*](http://strudel.cc).

It is web based REPL for music production, and the language most resembles
JavaScript, so it is suprisingly easy to get started and start making some
really cool dynamic compositions.

### Making Sounds

I made [this
sample](https://strudel.cc/#CmxldCBzbyA9IHNvdW5kKCJbPGJkIGJkPiA8aGggb2g%2BIGhoIGhoP10qNCIpLmJhbmsoInRyOTA5IikKbGV0IGhoID0gc291bmQoIjxoaD8uNSBoaCBoaD8uNT4qOD8uOSIpLmJhbmsoInRyOTA5IikKbGV0IGNwID0gc291bmQoIltjcEA0IC0gY3BANCAtXSIpCmxldCBiYiA9IHNvdW5kKCJbYmQgc2RdKjIiKS5nYWluKC43KS5scGYoMjAwKS5vcmJpdCgzKQpsZXQgc3F1YXJzID0gcygic3F1YXJlITgiKS5ub3RlKCJmIyBkZCEyLCBiYiBhI0AyLCAtIGQjLzIiKQpsZXQgc2F3cyA9IHMoInNhd3Rvb3RoKjQiKS5nYWluKC44KS5ub3RlKCJnYiE0PywgZGIhND8sIFtmIyBkIyBhI10hMiIpLnJvb20oLjIpCgovLyBzbwokOiBzby5nYWluKC4yKQoKLy8gYmFzZQokOiBiYi5nYWluKC4yKQoKLy8gY2xhcAokOiBjcC5nYWluKC4xKQoKLy8gaGlnaCBoYXQKJDogaGguZ2FpbiguMSkKCi8vIHN5bnRoCiQ6IHNxdWFycy5vcmJpdCgyKS5nYWluKC40KS5scGYoNDAwKS5nYWluKC4yKQokOiBzYXdzLnRyZW1vbG9zeW5jKCIxNiIpLnRyZW1vbG9za2V3KCI8MCAtMSAtMj4qMiIpCiAgLm9yYml0KDIsNCw3KS5hdHRhY2soIjwuMyAuMiAuMT4qNCIpCiAgLmp1eEJ5KC4yLCByZXYpLmdhaW4oLjIpCg%3D%3D)
just goofing around for a few minutes reading through the
[quickstart](https://strudel.cc/workshop/getting-started/).

```javascript
// You can run this in the REPL in Strudel
let so = sound("[<bd bd> <hh oh> hh hh?]*4").bank("tr909")
let hh = sound("<hh?.5 hh hh?.5>*8?.9").bank("tr909")
let cp = sound("[cp@4 - cp@4 -]")
let bb = sound("[bd sd]*2").gain(.7).lpf(200).orbit(3)
let squars = s("square!8").note("f# dd!2, bb a#@2, - d#/2")
let saws = s("sawtooth*4").gain(.8).note("gb!4?, db!4?, [f# d# a#]!2").room(.2)

// so
$: so.gain(.2)

// base
$: bb.gain(.2)

// clap
$: cp.gain(.1)

// high hat
$: hh.gain(.1)

// synth
$: squars.orbit(2).gain(.4).lpf(400).gain(.2)
$: saws.tremolosync("16").tremoloskew("<0 -1 -2>*2")
  .orbit(2,4,7).attack("<.3 .2 .1>*4")
  .juxBy(.2, rev).gain(.2)
```

I would not consider myself a particularly talented or informed person when it
comes to music theory or music production, but this kind of thing that melds
programming and art is something I find really cool and I hope you do as well.

### More Info

Strudel is free and open source (AGPL). You can find the source hosted on
[Codeberg](https://codeberg.org/uzu/strudel).

Also check out [eefano's
collection](https://github.com/eefano/strudel-songs-collection) of songs
converted to strudel.

Thanks for reading - go and make some cool sounds and share them!
