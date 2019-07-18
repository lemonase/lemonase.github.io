---
title: "Help! I'm rsync-ing"
date: 2019-07-05T18:08:42-04:00
draft: false
toc: false
images:
tags: 
  - files
  - transfer
  - copying
  - rsync
---

## What is rsync?

We can run the ```whatis rsync``` command to get a short description without opening the man page
```
rsync (1)            - a fast, versatile, remote (and local) file-copying tool
```
Rsync is the ultimate tool for copying files and is loved by many people.
It offers many advantages over traditional methods like SCP or FTP which are linear file transfer tools.
Rsync checks the delta of files between the source and the destination and only transfers the difference.
Additionally it allows an option for easy compression of files before they are sent over the network.

### Example usage

Say I have a folder of movies in my home directory on this computer that I wanted to copy to another machine I have ssh access to called **fry**. To do this I could use the command:

```sh
$ rsync -avz ~/Movies fry:~/Videos/
```

First let me cover what these options mean.
```man
-a, --archive
    Archive basically tells rsync to copy (and perserve) everything about the source files
    except hardlinks and extended attributes.
    It will also tell rsync to recurse into directories (-r).

-v, --verbose
    Prints out files to the stdout so you can see what's happening

-z, --compress
    Compresses data during transfer
```

As far as specifing directories, if it is on the local machine, just use the regular path to the directory.
If you are using a remote machine (ssh) as the source or destination, you will have to specify a hostname at minimum
and optionally a user, protocol, and port to use followed by a colon (:) and the desired path.
To use the rsync daemon, just add another colon (::).

One thing to note is if you are using -a or -r, you will be recursing into that directory. 
So just watch out if your source is a directory, the trailing forward slash will mean different things.

If it is not present (like in the example) the **directory itself** will be copied to the destination.

If it is present, **the contents** of that directory will be copied to the destination.


### Useful options

```man
-h, --human-readable
    Shows file sizes in appropriate measurements (MB, GB, TB, etc.)

-P, --partial and --progress
    This will show you a progress bar with files as they are transferred and will save partial files.

-n, --dry-run
    Test out an operation before you actually do it.

-u, --update
    Will skip files that are newer on reciever

-C, --cvs-exclude
    Skips folders for version control such as .git and other binary, object and temp files (see FILTER RULES)

```

While these may be the most common, there are many many more options for rsync and I recommend checking out the man page if you feel the urge.

