---
title: "Creative Commons Search Add-on (GSuite)"
date: 2019-09-13T00:15:17Z
draft: false
---

## Creative Commons Search Add-on for GSuite

<https://github.com/lemonase/CC-Search-G-Suite-Addon>

This was a project done for Google Summer of Code (GSoC) 2019

The idea was to integrate Creative Common's [image search engine](https://search.creativecommons.org/)
into GSuite products
The goal was to make the add-on as seamless as built-in Google Image Search,
but with CC/CC0 images only.

Naturally, it has more fine grained options for searching by specific licence
type and it automatically creates attribution text so the user doesn't forget.

The side-pane is written in vanilla HTML/CSS/JavaScript and the code that
interacts with the Slides app uses "Google App Script" which is also JavaScript
but Google hosts and runs the code along with the app that it targets 
(Slides/Sheets/Docs). It also provides OAuth and various APIs for GSuite.

Links:
- [Creative Commons Search Backend API](https://github.com/creativecommons/cccatalog-api)
- [Creative Common Frontend](https://github.com/creativecommons/cccatalog-frontend)
- [Crative Commons Search](https://search.creativecommons.org/)

- [Google App Script](https://developers.google.com/apps-script/)
