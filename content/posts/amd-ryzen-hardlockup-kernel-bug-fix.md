---
title: "AMD Ryzen 1700x Hardlockup Kernel Bug 'Fix'"
date: 2019-08-06T16:07:01-04:00
draft: true
toc: false
images:
tags: 
  - amd
  - linux
  - bug
  - grub
  - halt
---

I have been experiencing a hard system-lockup on my Ryzen system for a little
while now which has been both annoying and curious at the same time. When I say hard system-lockup,
I mean the kind where my whole system freezes and I cannot even drop into a virtual terminal
or do an Alt-SysRq.
This happens on both my Debian and Ubuntu installs running Linux kernel version
4.19 and 5.0.0 respectively.
It would happen almost randomly but especially when my CPU was mostly idle
and not much was going on.

I felt like this was likely a bug in the firmware/bios of my mobo or
in the kernel that was causing such a horrendous lockup, so I did
some digging online. I found [this](https://forum.level1techs.com/t/random-freezes-on-ryzen-in-linux-even-if-linux-is-in-vm/138913/11)
post on the Level1Techs forum that was more or less exactly the problem that I was facing. 
I also found posts on [AMD's website](https://community.amd.com/thread/225795), 
[AMD's sub reddit](https://www.reddit.com/r/Amd/comments/7skc45/when_is_amd_finally_going_to_fix_linux_crashing/), 
and [kernel.org](https://bugzilla.kernel.org/show_bug.cgi?id=196683)

Clearly I was not the only one having this issue, but unfortunately the solution
was not so clear.


## Kernel Paramters

One suggestion that comes out of this is to add
**'rcu_nocbs=0-n'** (where n is the number of cpus in your system)
to the **kernel command line**, which will theoretically
limit the number of cpu cores that will be dedicated to handling softirqs(software
interrupts) as long as your kernel was compiled with this option.
Read more about RCU's [here](https://utcc.utoronto.ca/~cks/space/blog/linux/KernelRcuNocbsMeaning).
Also adding **'idle=nomwait'** which will "Disable mwait for CPU C-states"
could also help to fix this problem from occurring.

---

On a distro that uses GRUB, you add these two parameters by editing
```
/etc/default/grub
```
and adding them to either
```
GRUB_CMDLINE_LINUX_DEFAULT (when booting into **normal mode only**) 

OR

GRUB_CMDLINE_LINUX (applies when booting in **normal and recovery** modes)
```
It should look something like
```
GRUB_CMDLINE_LINUX="idle=nomwait rcu_nocbs=0-7"
```
because I have an **8 core CPU**.

After that run
```
update-grub
```
and reboot your system and the changes should be in place

---
## BIOS/UEFI Settings

Other suggested fixes include tweaking various settings in the BIOS
such as memory timing/voltages, C-States(Power States) for the CPU
and idle power settings for the PSU if applicable.
There may or may not be options for some of these, but it is always
worth it to check out.

It may also be worth it to upgrade/downgrade BIOS versions as sometimes
settings get added or removed in revisions.

Finally if none of these workarounds help, some users just
opted to RMA their CPU's or Motherboards as this seems
like more of a hardware/power related bug than anything
else.

Just for reference, here are the specs of my machine

```
System:		Kernel: 4.19.0-5-amd64 x86_64
		Distro: Debian GNU/Linux 10 (buster) 

 Mobo:		ASUSTeK model: ROG STRIX B350-F GAMING

 CPU:		AMD Ryzen 7 1700X

 MEM:		32GB 

 Graphics:	AMD Radeon RX 480 Graphics (POLARIS10 DRM 3.27.0 4.19.0-5-amd64 LLVM 7.0.1) v: 4.5 Mesa 18.3.6 
		Driver: amdgpu 
```
