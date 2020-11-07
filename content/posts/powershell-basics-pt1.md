---
title: "Powershell Basics (Part 1)"
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

![PowerShell_Logo](/images/posts/powershell/PowerShell.jpg)
> <a href="https://docs.microsoft.com/en-us/powershell/scripting/community/digital-art?view=powershell-7">For non-commercial purposes documentation or on a website) that reference your connection with Microsoft PowerShell.
 </a>

## Things To Know About PowerShell

First and foremost, PowerShell is unlike traditional Unix/Linux shells such as bash or zsh.
It is _explicitly_ object oriented and the most of the benefits come from the
fact that the majority of "builtin" commands (also known as cmdlets) and
everything related to input/output comes in the form of
objects which in turn have members, methods and inheritance.
This way data is more "structured" compared to shells that deal with plain text.

## PowerShell design

PowerShell is more conducive to "drilling down" into objects to get specific data
rather than filtering through lots of output as is common with traditional shells.
Of course you can still filter through output, but one must consider that objects
are being piped around instead of text.
These design choices all have pros and cons, which can be discussed ad-nauseam,
so instead of trying to compare the two, I will try my best to go into it without
bias and be as objective as possible.

## PowerShell versions

The PowerShell version installed by default on Windows 10 is PowerShell 5.x,
and the executable is called `powershell.exe`.

The newer open source version [PowerShell Core](https://github.com/PowerShell/PowerShell)
(`pwsh.exe`) is the version that I will testing out and using on my Windows box.

You can tell which version of PowerShell you are using by typing `$PSVersionTable`,
which will print info about your running PowerShell process.

The syntax of every PowerShell command is in Verb-Noun form.
An example would be `Get-Process`

### How To Get Help

The official [PowerShell guide](https://docs.microsoft.com/en-us/powershell/scripting/learn/ps101/02-help-system?view=powershell-7)
says that the 3 commands you need to know to get help are

1. `Get-Command` - to see what a command actually is running
1. `Get-Help` - to see the help for a command (similar to the `man` on Linux)
1. `Get-Member` - to get the members of an object

### Help Aliases

The `Get-Help` command is actually aliased to both `help` and `man`, so running
those three commands is effectively the same thing. Aliases work very similarly
to other shells, to see all of them type `Get-Alias` or the alias `gal`. Aliases
are shown with `Get-Command` which shows every alias, cmdlet, function and
executable.

### Help Options

`Get-Help` and `Get-Command` both understand _wildcards_, and take options that can
narrow down both the search and output of the command.

#### Examples

List help for all commands that end in '-process'

```powershell
Get-Help *-process
```

Only get the examples from a help page (the `-Name` switch is optional)

```powershell
Get-Help -Name Get-ChildItem -Examples
```

List all commands with 'help' in the name

```powershell
Get-Command -Name *help*
```

`Get-Command` is a good way to see what type of command you're actually running
and the where it is located (under the Source column).

Now is also a good time to mention that **tab completion** is well supported in
powershell, as well as **Ctrl+Space**. Many functions in powershell have this
"fuzzy" quality about them, which almost makes up for the long-winded name
of some commands. Also things are case insensitive, but it is preferred
to use [PascalCase](https://techterms.com/definition/pascalcase#:~:text=PascalCase%20is%20a%20naming%20convention,in%20PascalCase%20is%20always%20capitalized.)
(or just spam the tab key like a true programmer)

### Types, Objects, Properties, Members and Methods

Getting into the meat of what PowerShell is all about, and the thing that differentiates
it from other shells. Let's start covering the OOP parts that tie into C#, and the environment.
An important command to explore PowerShell objects is `Get-Member`, and we'll see how to use
that in a useful inquisitive way.

`Get-ChildItem` simply lists all the files and directories (aka objects)
inside a directory.

`dir`, `ls`, and `gci` are all aliases for `Get-ChildItem`.

The output is something like this:

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

You may have noticed by running commands, that everything comes out kind of
looking like a table. This is not an accident, rather it is PowerShell
formatting things in a human-friendly way.

The first row of the table describes some **Properties** the are available, but not all of them.
To see _all_ the properties of these objects, you can pipe the command into `Get-Member`
using the `|` character.

```powershell
C:\Users\James\source\repos\blog> Get-ChildItem | Get-Member
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
...
```

This is a lot more output, but I truncated it for brevity.

This command gets all the members of each object contained in a directory.

The first thing to take note of is the `Type Name: System.IO.DirectoryInfo` at the
top of the output.

Types determine what you can and can't pipe from one command to the next, as well
as giving context to what it is you're looking at so they are an important concept
to grasp. They are based on the C# type.

A useful thing you can do with the type is query what other commands use it.

```powershell
Get-Command -ParameterType System.IO.DirectoryInfo
```

### Selecting Things

To narrow down output for a specific thing (thinks rows and columns),
the command to use is `Select-Object`.
It is useful for getting specific Properties, or getting the First, or Last
entries.

Get the Id and ProcessName of the first 10 processes

```powershell
Get-Process | Select-Object -First 10 -Property Id,ProcessName
```

If you are familiar with the `head` utility on Linux, this is similar. The main
difference is that you can also select specific properties with the `-Property`
parameter.

### Filtering Things

To filter properties based on rules or expressions, you can use `Where-Object`,
specifying the Property and how to filter.

```powershell
Get-Process | Where-Object {$_.WorkingSet -GT 250MB}
```

Here we are filtering Processes by the property `WorkingSet`, where the value
is greater than 250mb.
This syntax with curly braces '{}' indicates a script block. This is simply a
feature that makes complicated queries more readable.
The `$_` variable - also known as a pipeline variable is simply a shortcut for
the previous variable, or in this case, the previous command `Get-Process`.

So if we were to store the output of `Get-Process` in a variable, we could filter by the
WorkingSet property and then select the ProcessName and CPU.

```powershell
# store processes in $P variable
$P = Get-Process

$P | Where-Object {$_.WorkingSet -GT 250MB} | Select-Object -Property ProcessName,CPU
```

### Starting Things

In `CMD.EXE` the way to launch a new window or start a new process is using
[the `start` command](https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/start).
Running `start` in cmd is very similar to using the Run Dialogue (Ctrl+R).

This concept is carried into PowerShell as `start` is aliased to the
`Start-Process` cmdlet.

Command substitution uses the same syntax as bash with `$()`

To start chrome with the contents of my clipboard as an argument:

```powershell
Start-Process "chrome" -Arg "$(Get-Clipboard)"
```
