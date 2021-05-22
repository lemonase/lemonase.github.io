---
title: "A Minimal Vimrc"
date: 2021-05-02T20:07:18-04:00
draft: false
toc: true
images:
tags:
  - vim
  - minimal
  - config
  - settings
---

## Parts of a "minimal" vimrc

What makes a minimal vimrc?

My opinion of a "minimal" vimrc might be different from yours, but for me, it means

1. Not using external plugins
2. < ~100 lines
3. Reducing vi related pain-points

So here's what I do:

### Source default settings

While this may not be necessary most of the time, it is still worth it to check
that it has been sourced IME. It is a small fine to pay for ensuring you have
the defaults you deserve.

```vim
if filereadable(expand('$VIMRUNTIME/defaults.vim'))
	unlet! g:skip_defaults_vim
	source $VIMRUNTIME/defaults.vim
endif
```

And we're done...

jkjk there's more

### Settings

Most of these will already be set in `defaults.vim`, but that's not really a concern
of mine -- I still want to talk about them :)

#### "UI" Settings

```vim
set number	"show line numbers
set wildmenu	"enable a menu that shows tab completion options in the status bar
set showmatch	"highlights matching brackets on cursor hover
set ruler	"show cursor position in status bar
set showcmd	"shows the normal mode command before it gets executed
```

Gotta have those line numbers, and I use `wildmenu` _all the time_. The rest are just
nice-to-haves.

#### File Format and Encoding

```vim
set encoding=utf-8
set fileformats=unix,dos,mac
```

Lots of stuff is UTF-8 encoded these days (web pages, emojis, code, etc.)
this is the reasoning behind utf-8.

Setting `fileformats` instead of `fileformat` allows more than one EOL type to
be detected. For example: Windows uses both `<CR><NL>` to mark the end of a line
while Unix uses only one.
This is one reason you may see `^M` symbols at the end of each line.

See `h:fileformats` for more info.

#### Searching

```vim
set hlsearch	"highlights searches
set incsearch	"incremental search (searches character by character)
set ignorecase	"ignores the case of a search
set smartcase	"only ignores case if there are no capital letters in search (only works after ignorecase has been set)
```

While this is the search behavior that I like personally, I know that
many people prefer case sensitive search by default. I find `incsearch` jumps
around a bunch, which can be a bit disorienting, but I like the instant feedback.

#### Indents

```vim
set tabstop=4		"the amount of spaces that vim will equate to a tab character
set softtabstop=4	"like tabstop, but for editing operations (insert mode)
set shiftwidth=4	"used for autoindent and << and >> operators in normal mode
set autoindent		"copies indent from current line to the next line
set expandtab		"tabs will expand to whitespace characters
```

These indent settings can be confusing, but they apply in increasingly specific
ways.

Here is my understanding of it:

`tabstop` is your base level for what vim will think constitutes as a literal
`\t` "tab character".
It is 8 by default, but I set it to 4 because 4 is between 2 and 8 :D.

`softtabstop` only matters when editing (insert mode).

`shiftwidth` only applies when doing specific editing operators (>> and <<).

So if I set `softtabstop=2` and `tabstop=4`, I would have to hit the \<Tab\> key twice
to get an actual `\t` (tab character). And if I set `softtabstop=8` while
`tabstop=4`, I would get 2 tab characters when I press tab.

Then `expandtab` makes the `<Tab>` key insert spaces instead of tab characters.
You'll find this is necessary for languages like Python (thankfully these settings
are handled correctly in the default Python ftplugin under `$VIMRUNTIME/ftplugin/python.vim`)

`autoindent` and `smarttab` use the values from `softtabstop` and `shiftwidth`
to make indenting decisions too so watch out for that.

Tip: if you have any doubts about whether some space in a file consists of Tab
or a Space characters, use `:set list` to see `^I` for tab characters
Use `:set list!` to toggle.

#### Key Timeouts

```vim
set esckeys		"allows function keys to be recognized in Insert mode
set ttimeoutlen=20	"timeout for a key code mapping
set timeoutlen=1000	"time(ms) to wait for key mappings
```

These adjust the 'wait times' for different commands. These settings are
necessary to get rid of delay when running `vim` inside of `tmux`.

#### Syntax, Filetype and Matchit

```vim
syntax enable			"turn syntax highlighting on
filetype plugin indent on	"load plugin and indent files associated a detected filetype
runtime macros/matchit.vim	"allows jumping between brackets with % in normal mode
```

These are probably the settings the give the most "bang for buck" when it comes
to vanilla vim.

Syntax highlighting, filetype/language specific settings and plugins
are great, but they are a bit outside of the scope a truly minimal vimrc.

Once you start diving into the specifics of a language or ecosystem, you will likely
have an easier time using external tools provided to do the "heavy lifting" and
integrate with vim via plugin(s).

If you want to learn more about filetypes and plugins, see `:h filetypes`.

#### Autocommands

```vim
augroup general
    autocmd!
    "keep equal proportions when windows resized
    autocmd VimResized * wincmd =
    "save cursor position in a file
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"")
                \ <= line("$") | exe "normal! g'\"" | endif
augroup END

augroup languages
    autocmd!
    autocmd BufNewFile,BufRead *.bash set syntax=sh
    autocmd FileType python xnoremap <leader>r <esc>:'<,'>:w !python3<CR>
    autocmd FileType go set noexpandtab
    autocmd FileType html :syntax sync fromstart
    autocmd FileType html,javascript,css,json,yaml,sh
                \ setlocal ts=2 sts=2 sw=2 expandtab
augroup END
```

I have a few autocommands at the end here just in case I want to add specific
commands or mappings.

Autocommands are kind-of like 'events' that get fired when stuff happens inside
of Vim. They are an easy way set settings for filetypes or events.

For example, the following settings will only be applied to bash and go files
respectively.

```vim
    autocmd BufNewFile,BufRead *.bash set syntax=sh
    autocmd FileType go set noexpandtab
```

And that's all. 65 lines isn't too bad. I could probably axe a few settings
and some autocmds, but this is fine with me for now.

## The full file

[On GitHub](https://github.com/lemonase/dotfiles/blob/master/files/vim/.vim/vimrc.min)

```vim
"
" minimal vimrc with no (extra) plugins
"

"load system defaults
if filereadable(expand('$VIMRUNTIME/defaults.vim'))
	unlet! g:skip_defaults_vim
	source $VIMRUNTIME/defaults.vim
endif

"regular settings
"----------------
" ui
set number
set ruler
set wildmenu
set showcmd
set showmatch

" encoding/format
set encoding=utf-8
set fileformats=unix,dos,mac

" searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" indent
set shiftwidth=4
set tabstop=4
set softtabstop=4
set autoindent

" key timeout values
set esckeys
set ttimeoutlen=20
set timeoutlen=1000

" allow syntax and filetype plugins
syntax enable
filetype plugin indent on
runtime macros/matchit.vim

" autocmds
"---------
augroup general
    autocmd!
    "keep equal proportions when windows resized
    autocmd VimResized * wincmd =
    "save cursor position in a file
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"")
                \ <= line("$") | exe "normal! g'\"" | endif
augroup END

augroup languages
    autocmd!
    autocmd BufNewFile,BufRead *.bash set syntax=sh
    autocmd FileType python xnoremap <leader>r <esc>:'<,'>:w !python3<CR>
    autocmd FileType go set noexpandtab
    autocmd FileType html :syntax sync fromstart
    autocmd FileType html,javascript,css,json,yaml,sh
                \ setlocal ts=2 sts=2 sw=2 expandtab
augroup END
```
