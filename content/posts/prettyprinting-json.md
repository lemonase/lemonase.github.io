---
title: "Prettyprinting JSON with Python"
date: 2019-07-21T18:45:29-04:00
draft: false
toc: false
images:
tags: 
  - python
  - json
  - cli
  - tip
  - prettyprint
---

There are a number really awesome tools that can be used to view and validate JSON
files right from the command line. As it turns out, one such tool is built right
into Python as the json.tool module. Usage is as follows:

```sh
python -m json.tool [-h] [--sort-keys] [infile] [outfile]
```

If a single argument is given, it will validate the file and (pretty) print it to stdout.

---

This is all good and dandy, but what if I want to edit this JSON file now. I
could always write it to an output file and edit that, but that's just extra
steps to take.
To bring this trick to another level of handiness, I added this mapping to
my vimrc.

```vim
nnoremap =j :%!python -m json.tool<CR>
```

This will replace the content of the current buffer with the output of
this command. Now, whenever I find myself in an ugly crumpled up JSON file,
it only takes two keystrokes to get it formatted right!

I really like this solution becuase it is short, clean, and doesn't require installing
any additional programs.

Thanks Python! :green_heart:
