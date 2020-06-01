---
title: "AMD Ryzen 1700x Softlock Kernel Bug"
date: 2019-08-06T16:07:01-04:00
draft: false
toc: false
images:
tags:
  - amd
  - linux
  - power
  - kernel
  - bug
  - halt
  - freeze
---

## The Problem

I have been experiencing a hard "softlock" on my Ryzen system
which has been both annoying and interesting. Now, when I say hard "softlock",
I mean the kind where my whole system freezes and I cannot even drop into a virtual terminal
or do an Alt-SysRq. This happens on both my Debian 10 and Ubuntu 19.04 installs running kernel versions
4.19 and 5.0.0 respectively. It would happen almost randomly but prominently when my CPU was idle and not much was going on.

I assumed this was a bug in the firmware/bios of my mobo or in the kernel that was causing such a horrible lockup, so I did
some digging online.
I found [this post](https://forum.level1techs.com/t/random-freezes-on-ryzen-in-linux-even-if-linux-is-in-vm/138913/11)
on the Level1Techs forum that was more or less the same problem that I was facing.

I also found posts on [AMD's website](https://community.amd.com/thread/225795),
[AMD's sub reddit](https://www.reddit.com/r/Amd/comments/7skc45/when_is_amd_finally_going_to_fix_linux_crashing/),
and [kernel.org](https://bugzilla.kernel.org/show_bug.cgi?id=196683)

It seemed that I was not alone in experiencing this bug, but thankfully the community found some workarounds!

## Possible Fixes / Workarounds

### Fix 1: Kernel Parameters

One suggestion that comes out of this is to add
**'rcu_nocbs=0-n'** (where n is the number of cpus in your system)
to the **kernel command line**, which will theoretically
limit the number of cpu cores that can handle softirqs (software
interrupts), but note this will only work if your kernel was compiled with this option.
Read more about RCU's [here](https://utcc.utoronto.ca/~cks/space/blog/linux/KernelRcuNocbsMeaning).
Adding **'idle=nomwait'** will "Disable mwait for CPU C-states" and **'processor.max_cstate=1'**
will ensure that your cpu will not go into sleep states or in this case sleep paralysis.

On a distro that uses GRUB, edit `/etc/default/grub`
and adding the following options:

```shell
GRUB_CMDLINE_LINUX="idle=nomwait processor.max_cstate=1 rcu_nocbs=0-n"
```

Where "n" is the number of cpus -- **according to the kernel**
An easy way to find this out it to run `nproc`.

The difference between `GRUB_CMDLINE_LINUX_DEFAULT` and `GRUB_CMDLINE_LINUX` is that the first
will happen when booting in normal mode and the second happens in both normal and recovery modes.

So the parameters I added on my machine with a Ryzen 1700x are the following:

```shell
GRUB_CMDLINE_LINUX="idle=nomwait processor.max_cstate=1 rcu_nocbs=0-15"
```

After that run `update-grub` or `grub-mkconfig -o /boot/grub/grub.cfg` as root and reboot your system and the changes should be in place.

### Fix 2: BIOS/UEFI Settings

Other suggested fixes include tweaking settings in the BIOS
such as turning off C-States (Power States) for the CPU
and idle power settings for the PSU if applicable.

They will be under a menu called "**AMD CBS**"

### Fix 3: Disable with a script

Somebody also made a [handy Python script](https://github.com/r4m0n/ZenStates-Linux)
that will let you check or change the C-States on your CPU.
This is a good option if you don't want to disable C-States in BIOS or to confirm that they are actually disabled.

---

If none of these workarounds help, some users
opted to RMA their CPU's or Motherboards as this seems
like more of a hardware/power related bug than anything
else.

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
