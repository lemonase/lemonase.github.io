---
title: "Powershell Modules for Bash Users"
date: 2021-02-07T02:11:01-05:00
draft: false
toc: false
images:
tags:
  - powershell
  - bash
  - modules
  - scripts
---

I've been trying to get used to PowerShell for a little while now and while it
is difficult to adjust coming from other shells, there are some modules I have installed
that make it much less of a pain.

Modules are really core to what makes PowerShell extensible and you can [read more about them here](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_modules?view=powershell-7.1)
but they work similar to other OOP languages and just like other interpreted
scripting languages, loading too many modules will slow down performance.

With that out of the way,
here's a list of modules to make pwsh more like bash or zsh:

- [posh-git](https://www.powershellgallery.com/packages/posh-git/) - gives a prompt that shows git status
- [PSReadLine](https://www.powershellgallery.com/packages/PSReadLine/) - gives emacs/vim style keybinds
- [PSFzf](https://www.powershellgallery.com/packages/PSFzf/) - brings fzf to the realm of powershell

We can just iterate over a list to install these

```powershell
$modules = @("PSReadLine", "PSFzf", "posh-git")

foreach ($mod in $modules)
{
    Install-Module -Name $mod -Repository PSGallery -Force
}
```

And then to source, import or configure these modules, edit your `$PROFILE`

```powershell
# Posh
Import-Module posh-git

# PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle Visual

# PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
```
