---
title: "First Gen AMD Ryzen Kernel Freezing Bug"
date: 2019-08-06T16:07:01-04:00
draft: false
toc: false
images:
tags:
  - amd
  - linux
  - kernel
  - bug
  - halt
  - softlock
  - freeze
---

![Penguins](/images/posts/first-gen-amd-ryzen-kernel-freeze-bug/small-glacier.jpg)
> Image by <a href="https://pixabay.com/users/enriquelopezgarre-3764790/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=image&amp;utm_content=5584259">enriquelopezgarre</a> from <a href="https://pixabay.com/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=image&amp;utm_content=5584259">Pixabay</a>

## The Problem

I have been experiencing a hard freeze on my first gen Ryzen 1700x system
which has been very annoying.
This is the kind of freeze where I can't even drop into a virtual terminal
or do an Alt-SysRq.

This happens on both my Debian 10 and Ubuntu 19.04 installs running kernel
versions 4.19 and 5.0.0 respectively.
It would happen almost randomly but prominently when my CPU was idle and not
doing much.

I assumed this was a bug in the firmware/bios of my mobo or in the kernel that
was causing such a horrible lockup, so I did some digging online.
I found [this post](https://forum.level1techs.com/t/random-freezes-on-ryzen-in-linux-even-if-linux-is-in-vm/138913/11)
on the Level1Techs forum that was more or less the same problem that I was facing.

I also found posts on [AMD's website](https://community.amd.com/thread/225795),
[AMD's sub reddit](https://www.reddit.com/r/Amd/comments/7skc45/when_is_amd_finally_going_to_fix_linux_crashing/),
and [kernel.org](https://bugzilla.kernel.org/show_bug.cgi?id=196683)

It seemed that I was not alone in experiencing this bug related to CPU power
states.

## Possible Fixes / Workarounds

### Fix 1: Disable C-States With Kernel Parameters

On a distro that uses GRUB, edit `/etc/default/grub` go ahead and add the
following options:

```shell
GRUB_CMDLINE_LINUX="processor.max_cstate=1 idle=nomwait rcu_nocbs=0-n"
```

> "n" is going to be (number of cpus) - 1.
> If you are unsure how many cores your cpu has, run `nproc`.

After that run `update-grub` or `grub-mkconfig -o /boot/grub/grub.cfg`
as root and reboot your system and the changes should be in place.

#### Explanation

Adding **'processor.max_cstate=1'**
will ensure that your CPU will not go into sleep states which seems to be the
cause of the halting on these early Ryzen CPUs.
I have had success with this option. There are no guarantees it will work
for you -- but I recommend trying it.

Adding **'rcu_nocbs=0-n'** limits the number of CPU cores that the kernel
assigns to handle softirqs (software interrupts),
but note this will only work if your kernel was compiled with this option --
I think this is the case with most distros.
Read more about RCU's [here](https://utcc.utoronto.ca/~cks/space/blog/linux/KernelRcuNocbsMeaning).

Adding **'idle=nomwait'** will "Disable mwait for CPU C-states" as a possible
mitigation for the issue.

### Fix 2: Disable C-States With A Python Script

Github user r4m0n made a [handy Python script](https://github.com/r4m0n/ZenStates-Linux)
that will let you check or change the C-States on your CPU.
This is a good option if you don't want to disable C-States in the BIOS or for
confirming that CPU C-States are actually disabled.

### Fix 3: Disable C-States and Idle Power Settings In BIOS/UEFI

Other suggested fixes include tweaking settings in the BIOS
such as turning off C-States (Power States) for the CPU
and idle power settings for the PSU if applicable.

They should be under a menu called "**AMD CBS**"

### System Specs

For reference, here are the specs of my machine

```config
 System:    Kernel: 4.19.0-5-amd64 x86_64
            Distro: Debian GNU/Linux 10 (buster)

 Mobo:      ROG STRIX B350-F GAMING

 CPU:       AMD Ryzen 7 1700X

 MEM:       32GB

 Graphics:  AMD Radeon RX 480 Graphics
            (POLARIS10 DRM 3.27.0 4.19.0-5-amd64 LLVM 7.0.1)
            v: 4.5 Mesa 18.3.6
            Driver: amdgpu
```

If none of these workarounds help, some users reported success from opting to
RMA their CPU's for newer models.

## November 2020 Update

Looking at recent kernel bug reports, this seems to be an ongoing CPU firmware
bug in Linux that is still affecting first gen Ryzen CPUs out there.

I have been running Arch on the same hardware with kernel version 5.9.4 as of writing.
Running with `processor.max_cstate=1` with no lockups in a heck of a long
time, but I have seen other's say that this doesn't work for them.

I can also confirm that there is no issue with the CPU on Microsoft Windows 10.
It seems like a bug somewhere in the Linux's microcode/firmware for
power management in AMD CPUs. AMD has also not given a definitive answer/fix yet
which is unfortunate.

