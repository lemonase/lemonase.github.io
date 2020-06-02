---
title: "Reading Lines From Files"
date: 2020-05-28T03:14:39-04:00
draft: false
toc: false
images:
tags: 
  - bash
  - python
  - c
  - files
  - lines
  - shell
  - posix
  - read
---

Reading input line by line is something that seems like a basic
operation, but one that is common nonetheless.

Let's look at a couple ways we can do this in Bash and other languages like Python and C.

## Bash

The syntax of bash always seemed a little out of place to me.

For this example, assume we have a file called `test.txt` and we want
to echo every line.

```shell
while read -r line; do
    echo $line
done < test.txt
```

piping cat into the while loop works as well

```shell
cat file.txt | while read -r line; do
    echo $line
done
```

### Shell Strangeness

In practice, echoing lines this way is useless, because cat already does that.
However it is a perfect demonstration of how working in the shell relies
heavily on the redirection of input/output.

It also demonstrates a piece of the strange and fantastic world that is shell scripting.
Piping input into a while read loop looks rather odd, but it makes sense in the
context of a shell, and how the `read` builtin works.

Another **big** thing to note here is that there are some complex rules regarding white-space
and the `read` command. I won't go into too much detail, but the `IFS` variable 
controls what fields the arguments to `read` are separated by. The default is space, but can be changed
to a newline, comma, tab, or anything else. Regular shell escaping with backslashes still applies,
so it is recommended to use `-r` to stop that behavior.

### Xargs

Another way to "read" a file in shell is with `xargs`, which takes input and runs a command for every field of input.
Like `read` the default field separator is white-space. Some interesting options are `-l`, which tells xargs
to set 1 as the max number of lines. In other words one command per (non-whitespace) line. The `-n#` option
is also good to know, which tells xargs to use a certain number of arguments for a given command.

Tell xargs to run echo on every (non-whitespace) line in test.txt:

```shell
xargs -l echo < test.txt
```

Tell xargs to run echo after every 2 arguments (separated by whitespace) in test.txt:

```shell
xargs -n2 echo < test.txt
```

I know these are simple uses for xargs, but this technique can be
incredibly useful after filtering some data and feeding it to xargs
to turn it into arguments of another command.
It is a configurable argument aggregator.

### Shell Powers

In Unix shells, the concept of files, and file descriptors (stdin, stdout, and stderr) are often interchangeable.

Using operators such as the pipe `|`, and redirecting stdin `<` and stdout `>` are absolutely vital to
understanding how the shell operates. Command substitution `$()`, fd substitution `<()` and subshells `()` are essential to
bash scripting as well.

### Useless Catting

Some people feel starting a command with cat and piping into other programs is bad practice and extraneous.
See [Useless Use Of Cat](http://porkmail.org/era/unix/award.html#cat) for a good read about bad practices in shell scripts.

On the other hand, some tools do not accept a filename directly, and thus using cat to output a file
to stdout is perfectly acceptable. It really depends on the tool, which can be annoying as the behavior of commands
is not always the most consistent thing in the world, despite POSIX standards.
I feel like in most cases, an extra call to `cat` is not going to hurt anything, but should probably not be the default
way to pass a file to a command if that is the intention.

### Downfalls

You may already see why someone would prefer not to script with the shell at all.
Inconsistent syntax, weird default behavior, lots of escaping quotes, lack of proper debugging, no libraries, etc,..
These little inconsistencies start to add up with time and complexity, and the inconvenience starts to outweigh the convenience.

Languages like Perl, Ruby, Python, and Node.js and continue to fill the gap between a statically typed, compiled language 
like C/C++ and shell scripts.

## Python

Take the same `test.txt` file as before, but let's use python.

```python
#!/usr/bin/env python

with open('test.txt') as f:
    for line in f:
        print(line, end="")
```

For this example, line is a type "str" and newlines are the default separator
Iterating over this file assigns `line` to a string representing the current line.

Compared to Bash/Shell, Python is much easier to understand and write.
Partly because the simpler syntax, but also because of sane defaults.

The price that Python pays for having such friendly default abstractions is performance,
which granted, is not a huge requirement for many applications.

In order to dig deeper, we will have to go to a lower level of abstraction, so let's C. 

**Disclaimer** I am not an expert C Programmer, but I'm learning, so if anything
sticks out as wrong, please let me know.

## C

First let's open a file on our own, then take a look at how CPython opens a file, and
how that translates into Python.

According to `man open.3`, the synopsis is as follows:

```c
#include <sys/stat.h>
#include <fcntl.h>

int open(const char *path, int oflag, ...);
int openat(int fd, const char *path, int oflag, ...);
```

Calling `open()` gives you a file descriptor and opens up a file description at the path supplied, with the flags supplied.
`fcntl.h` defines all the flags used to open a file and `sys/stat.h` provides other file access information.

There is a friendlier POSIX wrapper around `open` called `fopen` and it's description is: 

	The fopen() function opens the file whose name is the string pointed to by pathname and associates a stream with it.

```c
#include <stdio.h>

FILE *fopen(const char *pathname, const char *mode);

FILE *fdopen(int fd, const char *mode);
```

If you don't *need* the file descriptor, and would rather work with pointers to a file,
this seems to be the preferred method as far as I can tell.

So let's see a program that reads a file line by line

```c
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char** argv) {
    // open a file
    FILE *fp;
    fp = fopen("test/file.txt", "r");
    if (fp == NULL)
        exit(EXIT_FAILURE);

    // declare line variables
    const size_t line_max = 300;
    char* line_buffer = malloc(line_max);

    // fgets reads a file pointer, stops at a newline and fills the line_buffer until line_max
    // the loop continues until there is a line that is empty or NULL
    while(fgets(line_buffer, line_max, fp) != NULL) {
        printf("%s", line_buffer);
    }

    // free memory
    free(line_buffer);
}
```

As is expected with a lower level language, there is more manual work involved in opening a file and reading it.
There is much more the programmer has to worry about, such as allocating the correct amount of memory, remembering to free
it, NULL terminated strings, bounds checking, pointers and *tons* of other things that come along with that.

Note these are important details about how the program works, but can get in the way of implementing application logic.
The syscalls exposed by the kernel and the implementation of the C Standard Library are vital to Linux/UNIX systems
and working in lower level languages will force you think differently about problems.

I hope this was a decent tour of how files to open and read files at higher and lower level languages.

