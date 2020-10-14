---
title: "PowerShell Basics"
date: 2020-06-29T16:11:02-04:00
draft: false
toc: true
images:
tags:
  - powershell
  - microsoft
  - windows
  - automation
  - IT
---

The main focus on this blog so far has been GNU/Linux stuff,
and I do plan on keeping it that way, but the popularity of Windows is such that,
one cannot work with computers and simply ignore it.
Learning a little bit about Windows is really not the worst thing in the world.

But everyone knows the Windows Desktop experience, right?
The start menu, the taskbar, explorer.exe, task manager, mspaint, control panel,
letter drives, System32, _cmd.exe_, _the registry_ (queue horrific screaming).
You love it, you hate it, everyone uses it, and now it updates every 6 months.
Hurray!?!

## Why Learn PowerShell

It is a personal goal of mine to be as versatile as possible, and effective
no matter what OS I encounter. This may be a silly goal, but nevertheless it leads
to learning new things, and new ways of doing things which I would not have
known about otherwise.

It is a common mentality among Linux and Mac (POSIX) people, that they don't want to
learn **anything** created by Microsoft and _especially_ not Windows stuff.
I think that while this attitude (avoid anything microsoft) may have been more
justified in the past, it will be less so going into the future.

I'll explain a couple reasons why.

### Knowledge = Power

A scripting language such as Python (for general purpose stuff), bash/zsh (on Linux/Mac)
or PowerShell (on Windows) is a must if you really want to break down the hurdles
that come with using a GUI for everyday tasks. It is the first
step into becoming a "poweruser" and the freedom that comes with that is
something Linux and Mac users have touted over Windows for a long time, but
it seems Microsoft is finally catching up in a big way.

### Massive User Impact

I don't think it is fair to disregard any technology that has the capability to
unburden people from their daily tasks (even if that task is dealing with windows)
simply because something is different or made by a company you don't like.
There are tons of valid reasons to hate technology, but they should come from
real experiences and not hearsay or groupthink.

#### An Example

The [Window10Debloater](https://github.com/Sycnex/Windows10Debloater) script
is an awesome example of what can be done with the PowerShell scripting.

It uninstalls tons of those stupid preinstalled Apps that nobody wants
(like Farmville and CandyCrush). Instead of going to Settings or Control Panel
and individually clicking and uninstalling all these apps one by one, you just
run this simple script and they're gone.

The best part about this is that you don't have to install more bloatware to
get rid of the bloatware.

### Windows Has The Desktop Market

The fact of the matter is that Windows still dominates the desktop market,
hovering between 70% to 80% marketshare.
If you want to support the majority of desktop users, you have no choice but to
support Windows.

Linux takes up a single digit percentage of the desktop market, so
the ongoing joke among Linux users is the fabled "year of the Linux desktop",
where Linux will take over. Well, it is happening in the background (kind of)

#### WSL 2 (Windows Subsystem for Linux)

[WSL2](https://docs.microsoft.com/en-us/windows/wsl/compare-versions)
is setting the stage for the "year of the Linux desktop", but not the way that
many people expected.

WSL2 basically runs a hypervisor on your machine that runs both Windows 10
and Linux side by side, with some extra processes to assist with interoperability.

Changes have been made to Windows to allow filesystem, network, and even graphics
to be shared between your desktop and the Linux VM. It is still early, and the
whole experience can be a bit rough around the edges, as you would expect when you smash two
Operating Systems together, but it works suprisingly well and lets you run
bash in a fully virtualized Linux distro such as Ubuntu, instead of something like
MinGW or Git Bash, which are both crude emulations of a Linux environment and the
source of many headaches.

#### Thoughts On Use Cases

WSL is a cool proof of concept, but here are my feelings about it when it comes
to work:

If the you're using Windows and want virtualize Linux that is fine, but you can't
expect a "native" experience when using Linux apps. At the end of the day, it
is still a Virtual Machine, albeit a very lightweight one.

It is the same with Linux if you want to virtualize Windows or use WINE to play
games or something. You can't expect a "native" experience with that either.

There is no guarantee of performance, and sometimes all the tweaking in the world
cannot make things work correctly.

## Windows and the "New" Microsoft

### Open Source

**Microsoft** -- the world's largest and well known producer of proprietary closed source
software bought **GitHub** -- the world's largest open source git hosting service for
\$7.5 billion in 2018.

Since then they have made some commitments to Open Source --
some projects include .NET Core, Powershell Core, VS Code and WSL2.

All of these products serve to "bring Windows to the 21st century" as it were,
all the while adopting OSS and making Windows an environment where developers
can develop for platforms **other than Windows** -- _finally_.

They are still in the "building trust" phase with the community. Many people are
rightfully cautious about trusting Microsoft. They are infamous for their
anti-consumer pratices. Before they rebranded, they didn't exactly have the best
track record with open source either, but they are quickly making up for it.

Just like Apple, Amazon or Google, it is in their best interest to attract a
wider pool of developers to create software using their languages, frameworks,
tools, platforms and cloud services in order to stay competitive. All these
companies want the same thing -- more profit and growth -- and granted they've
been pretty successful at cornering their respective markets.

As a developer, it's important to recognize this demand and realize just how
powerful and profitable open source software can be to the likes of FAANG and
any company that relies on OSS.

It would be very hard for them to step away from open source at this point,
at least when it comes to new developments. Of course there will be parts of
Windows like Win32 and DirectX APIs, that will probably stay locked up forever,
but that's to be expected.

### The Need For Windows Automation

GUI's may be easier, prettier and more intuitive to use and explore a system,
but they are really bad when it comes to things that must be done repeatedly.

Clicking through submenu after submenu may be easy at first, but it comes at a
very real cost if a function doesn't have a command or cannot be bound to a
hotkey or a macro.

### The Need For PowerShell

PowerShell aims to be "the definitive shell" of Windows going forward, while
`cmd.exe` will slowly fade away, but likely stay on systems for many years
to come.

This leads me to the real reasons why I want to learn PowerShell, not only to see what
it is capable of, but to see what the future of Windows CLI will be like.

Let's dive in.

## Things To Know About PowerShell

Powershell is an object oriented shell, where "everything is an object" with
members and methods galore. The structured data can be piped around, filtered,
and sent places. The majority of commands -- or cmdlets as they are called in PowerShell
are actually functions written in PowerShell or C#. The PowerShell installed
by default is PowerShell 5, and the executable is called `powershell.exe`.
The newer open source version is PowerShell 7 (`pwsh.exe`), which is the version
that I will be using.

The general syntax of commands in powershell is Verb-Noun.
An example is `Get-Process`

### First Commands

The official powershell guide says that the 3 commands you need to know are

1. `Get-Command`
1. `Get-Help`
1. `Get-Member`

### Aliases

The `Get-Help` command is actually aliased to both `help` and `man`, so running
those three commands is effectively the same thing. Aliases work very similarly
to other shells, to see all of them type `Get-Alias` or the alias `gal`. Aliases
are shown with `Get-Command` which shows every alias, cmdlet, function and
executable.

### Help Options

`Get-Help` and `Get-Command` understand wildcards, and takes options that can
narrow down both the search and output of the command.

List help for all commands that end in '-process'

```powershell
Get-Help *-process
```

Only get the examples from a help page

```powershell
Get-Help -Name Get-ChildItem -Examples
```

List all commands with 'help' in the name

```powershell
Get-Command -Name *help*
```

This is a good way to see what type of command you're actually running and the
Path (under the Source column).

### Types, Objects, Properties, Members and Methods

Getting into the meat of what PowerShell is all about, and what differentiates
it from other shells, let's start covering the OOP parts that tie into C#.
The imporant command from above will be `Get-Member`, and we'll see how to use
that in a useful inquisitve way.

You may have noticed by running commands, that everything comes out kind of
looking like a table.

For example if I run `dir`, which is an alias for `Get-ChildItem`, I get this:

```text
    Directory: C:\Users\James\source\repos\blog

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d----           6/30/2020 12:45 AM                .git
d----           1/19/2020 12:29 AM                archetypes
d----           1/19/2020 12:17 AM                assets
d----           6/29/2020  4:10 PM                content
d----           1/19/2020 12:17 AM                layouts
d----          10/14/2019  1:42 PM                resources
d----           10/5/2019 11:32 AM                static
d----           1/19/2020 12:17 AM                themes
-a---           4/24/2019  9:38 AM             39 .gitignore
-a---           1/19/2020 12:17 AM             97 .gitmodules
-a---           6/29/2020  4:08 PM           1978 config.toml
-a---           6/29/2020  4:08 PM            510 README.md
-a---           6/29/2020  4:08 PM            116 topics.md

```

The first row describes some **Properties** the are available, but just a few.
To see _all_ the properties, you can pipe the command into `Get-Member`

```powershell
Get-ChildItem | Get-Member
```

```text


   TypeName: System.IO.DirectoryInfo

Name                      MemberType     Definition
----                      ----------     ----------
LinkType                  CodeProperty   System.String LinkType{get=GetLinkType;}
Mode                      CodeProperty   System.String Mode{get=Mode;}
ModeWithoutHardLink       CodeProperty   System.String ModeWithoutHardLink{get=ModeWithoutHardLink;}
Target                    CodeProperty   System.String Target{get=GetTarget;}
Create                    Method         void Create()
CreateSubdirectory        Method         System.IO.DirectoryInfo CreateSubdirectory(string path)
Delete                    Method         void Delete(), void Delete(bool recursive)
EnumerateDirectories      Method         System.Collections.Generic.IEnumerable[System.IO.DirectoryInfo] EnumerateDirectories(), SyΓÇª
EnumerateFiles            Method         System.Collections.Generic.IEnumerable[System.IO.FileInfo] EnumerateFiles(), System.CollecΓÇª
EnumerateFileSystemInfos  Method         System.Collections.Generic.IEnumerable[System.IO.FileSystemInfo] EnumerateFileSystemInfos(ΓÇª
Equals                    Method         bool Equals(System.Object obj)
GetDirectories            Method         System.IO.DirectoryInfo[] GetDirectories(), System.IO.DirectoryInfo[] GetDirectories(strinΓÇª
GetFiles                  Method         System.IO.FileInfo[] GetFiles(), System.IO.FileInfo[] GetFiles(string searchPattern), SystΓÇª
GetFileSystemInfos        Method         System.IO.FileSystemInfo[] GetFileSystemInfos(), System.IO.FileSystemInfo[] GetFileSystemIΓÇª
GetHashCode               Method         int GetHashCode()
GetLifetimeService        Method         System.Object GetLifetimeService()
GetObjectData             Method         void GetObjectData(System.Runtime.Serialization.SerializationInfo info, System.Runtime.SerΓÇª
GetType                   Method         type GetType()
InitializeLifetimeService Method         System.Object InitializeLifetimeService()
MoveTo                    Method         void MoveTo(string destDirName)
Refresh                   Method         void Refresh()
ToString                  Method         string ToString()
PSChildName               NoteProperty   string PSChildName=.git
PSDrive                   NoteProperty   PSDriveInfo PSDrive=C
PSIsContainer             NoteProperty   bool PSIsContainer=True
PSParentPath              NoteProperty   string PSParentPath=Microsoft.PowerShell.Core\FileSystem::C:\Users\James\source\repos\blog
PSPath                    NoteProperty   string PSPath=Microsoft.PowerShell.Core\FileSystem::C:\Users\James\source\repos\blog\.git
PSProvider                NoteProperty   ProviderInfo PSProvider=Microsoft.PowerShell.Core\FileSystem
Attributes                Property       System.IO.FileAttributes Attributes {get;set;}
CreationTime              Property       datetime CreationTime {get;set;}
CreationTimeUtc           Property       datetime CreationTimeUtc {get;set;}
Exists                    Property       bool Exists {get;}
Extension                 Property       string Extension {get;}
FullName                  Property       string FullName {get;}
LastAccessTime            Property       datetime LastAccessTime {get;set;}
LastAccessTimeUtc         Property       datetime LastAccessTimeUtc {get;set;}
LastWriteTime             Property       datetime LastWriteTime {get;set;}
LastWriteTimeUtc          Property       datetime LastWriteTimeUtc {get;set;}
Name                      Property       string Name {get;}
Parent                    Property       System.IO.DirectoryInfo Parent {get;}
Root                      Property       System.IO.DirectoryInfo Root {get;}
BaseName                  ScriptProperty System.Object BaseName {get=$this.Name;}

```

This is a lot of output, but that's ok.

The first thing to take note of is the `Type Name: System.IO.DirectoryInfo` at the
top of the output.

Types determine what you can and can't pipe from one command to the next, as well
as giving context to what it is you're looking at so they are an important concept
to grasp.

A useful thing you can do with the type is query what other commands use it.

```powershell
Get-Command -ParameterType System.IO.DirectoryInfo
```

### Selecting Things

To narrow down ouput for a specific thing, the command to use is `Select-Object`.
It is useful for getting specific Properties, or getting the First, or Last
entries.

Get the id and name of the first 10 processes

```powershell
Get-Process | Select-Object -First 10 -Property Id,ProcessName
```

### Filtering Things

To filter properties based on rules or experssions, you can use `Where-Object`,
specifying the Property and how to filter.
