---
title: "Neovim Config"
date: 2025-08-09T20:21:55-04:00
draft: false
---

I remember when I initially tried Neovim a few years ago, I was
mostly focused on rewriting my existing Vim configuration from Vimscript
to Lua.

I ended up splitting parts of my config up into separate 
folders and lua files.

I separated my user configurations from plugin configuration
like this:

```
~/.config/nvim/lua/
├── config
│   ├── keymaps.lua
│   ├── lazy.lua
│   ├── local.lua
│   ├── platform_specific.lua
│   └── settings.lua
└── plugin-config
    ├── cmp.lua
    ├── colorscheme.lua
    ├── fzf.lua
    ├── gitsigns.lua
    ├── init.lua
    ├── lsp.lua
    ├── nvim-treesitter.lua
    ├── oil.lua
    └── vim-fugitive.lua

3 directories, 14 files
```

* The files in `config/` are required from my `init.lua`
* `plugin-config/init.lua` is required from my `init.lua`
* The files in `plugin-config/` are required from `plugin-config/init.lua`

Overall, this is a much cleaner way than a single file that
is 100 or possibly 1000s of lines long. It also ensures each
plugin has its own configuration file, which I really prefer.

## Thoughts on Neovim

The main things that attract me to Neovim (over vanilla vim)
are:

1. More sane defaults compared to Vim/Emacs
1. More structured/flexible configuration (feelings for Lua aside)
1. Better support for LSP integration

Of course, after using Emacs for a few weeks/months, I now see
how Neovim is taking the Emacs philosophy of integrating every tool
into the editor. This can be a good thing if you are fully 
invested into the editor, the Neovim community is **strong** afterall,
however it does lead to much of the same functionality being re-invented.

This goes for functionality that is builtin to GUIs (image viewing) as well
as fuzzy finding (shell), but that is a much broader topic than just Neovim
and it runs into what terminals are capable of in 2025.

## Plugin Managers

One source of churn has been the (neo)vim plugin manager.
In Vim, I still use [`vim-plug`](https://github.com/junegunn/vim-plug)
for convenience and in Neovim, I use [`lazy.nvim`](https://github.com/folke/lazy.nvim).

One recent development that has me excited for the future of Neovim is the inclusion
of a built-in package manager (`vim.pack`) coming in Neovim version `0.12`.

It has always been a minor annoyance that various package manager solutions exist
for (neo)vim and they all have to be bootstrapped.

Having a built-in package manager is a good move for plugin authors and users
going forward.

Of course the ability to use other package managers (or clone repos with a
script) will remain, but this proves that Neovim devs are paying attention to
what the community wants, which is good.

---

If you are interested in my Neovim config, check it out [here on Github](https://github.com/lemonase/dotfiles/tree/master/config/nvim/.config/nvim).

Thanks for reading, and happy configuring!
