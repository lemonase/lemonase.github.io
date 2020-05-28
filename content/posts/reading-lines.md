---
title: "Reading Lines"
date: 2020-05-28T03:14:39-04:00
draft: true
toc: false
images:
tags: 
  - untagged
---

Reading lines of a file is one of the most common things to do with (text) files.

Let's look a ways we can do this in bash and other lanugages.

## Bash

The syntax of bash always seems a little out of place to me.

```shell
while read line; do
    echo $line
done < file.txt
```

alternatively, piping cat into the while loop works just aswell

```shell
cat file.txt | while read line; do
    echo $line
done
```

But don't do this online because people will make fun of you because this is pretty usesless
on its own.
