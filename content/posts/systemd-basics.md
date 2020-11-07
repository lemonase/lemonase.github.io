---
title: "Booting, init and systemd basics"
date: 2020-07-22T15:05:41-04:00
draft: false
toc: false
images:
tags:
  - init
  - booting
  - systemd
  - unix
  - linux
---

## Init Systems

The **initial process** that runs on a Unix/Linux system is responsible for
forking the rest of the processes that are needed in order to "boot" the
system. This is the core function of an init-system. It is effectively the first process
where execution is handed off from the kernel to "userspace", where processes
get PIDs, cpu time and network/memory/disk access via calls to the kernel or kernel modules
(drivers).

## Booting

The reason I put boot in quotes is because the actual boot process that happens on a
modern computer involves many complex underlying systems handing off
execution and initialization to the next.

The stages of booting generally go like this:

Power On -> UEFI/BIOS -> Bootloader -> Kernel -> init (systemd)

1. Pressing the Power On button starts with **power** and **hardware**
   and the first thing that happens is a **POST** (Power On Self Test),
   which ensures that the hardware is getting enough power, and
   everything is functioning as expected.

1. Special non-volatile memory (typically found on the Motherboard) has software
   and settings called either a legacy **BIOS** (Basic Input/Output System) ROM or
   the modern equivalent **UEFI** (Unified Extensible Firmware Interface). Modern
   UEFI implementations take over some of the roles of a bootloader, and have more
   features, like GUIs and network connectivity (but this all depends on the motherboard
   and firmware implementation).

1. The BIOS/Firmware looks for a **boot drive**, or more specifically, a special **partition**
   on the boot drive that has a program known as a **bootloader**. Different Operating Systems
   can be picky about partition schemes and filesystems, so it is best to do your research
   before messing with or creating boot partitions on systems and drives that you care about.
   The most popular bootloaders include GRUB 2, rEFInd and Clover.

1. The bootloader partition (usually mounted on `/boot` on Linux systems) includes
   a **kernel** (a compressed kernel image called _vmlinuz_) and a **initial ram filesystem**
   (a compressed filesystem that gets decompressed into memory
   to load **kernel modules** before init and the root `/` filesystem get mounted)
   Hopefully the kernel, or a kernel module has the **drivers** needed to make the rest of your hardware
   (like your keyboard, mouse, graphics card, network card, etc.)
   accessible to userspace programs through higher layers of abstraction (like libraries) and userspace programs
   (like a GUI, shell or Web Interface).

1. These higher layers of abstraction are provided by pre-compiled libraries, which are similar
   to executables, but they are not run directly, they are loaded into memory by processes that
   link to them, which is something that happens at **compile time**, using something called
   **dynamic linking** -- something that is facilitated through a combination of features provided
   by the compiler, linker, and the kernel. The idea is that linking executables to libraries that
   contain common code will save disk space, promote code re-use and generally make life easier.
   The alternative is called **static linking** and it basically pulls all the code into a single
   executable. This is up to the developer with C/C++ and the default in Go.

   In Windows, libraries are called "Dynamic Linked Libraries" and end in a '.dll' extension, and in Linux,
   they're called a "Shared Object" or "Kernel Object" and the extension used is '.so' and '.ko' respectively.

   In an OS model where processes are created with **fork** or **clone**, every process must have a parent,
   and can be traced back to an **init system** (another way of saying "the first program that is loaded")

## Where Booting Becomes Init

In other words the init system is the last stage of the booting process and
relies entirely on data structures and software constructs provided by the
kernel such as processes, threads, sockets, files and filesystems. PID 1 is
a _special process_ with lots of duties, but it is still _just a process_
in the eyes of the kernel (for the most part).

## Naming and Conventions

### Daemons

A [daemon](<https://en.wikipedia.org/wiki/Daemon_(computing)>) is the technical
term for a process that runs in the background and forks into other processes
-- including other daemons. An example of this is systemd starting dockerd (the
docker daemon). Another name for this type of process (in the context of an OS)
is a service, although the term "service" can be ambiguous and highly dependent
on the context, whereas a daemon generally means one thing.

For Unix, it is customary to name daemon processes something that ends in a `d`
to identify itself as a daemon.

### Brief History of Systemd

`systemd` follows in the tradition of naming, but diverges from the traditional
role of an "init system" in just about everything else that it does.
It started in 2010 as a reasonably sized project that sought to replace the old sequential init
systems that ran shell scripts with something that was capable of starting
processes in parallel. This sped up boot times _substantially_, and
was a necessary step in moving forward. But not all features have been received
with the same enthusiasm.

Anywhere systemd is mentioned online, there is always contention over the infamous
feature creep which can only be described as a never-ending crusade through
Linux userspace where systemd slowly consumes every aspect of system management
-- for better or worse.

This style of development is directly opposed to the Unix philosophy which is
"do one thing and do it well", and admins have mixed feelings about such widespread
adoption of such a large chunk of software.

Supporting a single init system for all Linux distros is a
big weight off developers, but many are worried that putting such
trust in the hands of systemd maintainers is dangerous, as they don't have
the best history of respecting user's feedback, and the scope of the project
has not stopped expanding since it's creation.

### How Daemons Work

Daemons can be controlled and configured through a variety of
IPC (Inter Process Communication) mechanisms like sockets, pipes, and signals.
These are typically placed in the `/run/` directory.
There are configuration files that can change the default behavior of
a daemon as well.

`systemctl` for example, uses a private socket `/run/systemd/private` for communication
with the daemon. It is also possible (but not recommended) to send signals
to `systemd` with the `kill` command.

`man systemd` gives more info on what signals, sockets and pipes systemd uses.

### systemctl

`systemctl` is the one-stop-shop for interacting with systemd units and
machine states.
The commands are pretty uniform and easy to understand.

#### Listing units

```sh
systemctl list-units
systemctl list-unit-files
systemctl list-dependencies
```

#### Checking/Observing units

```sh
systemctl status <unit>
systemctl show <unit>
```

#### Changing unit states

```sh
systemctl enable <unit>
systemctl disable <unit>
systemctl start <unit>
systemctl stop <unit>
```

#### Changing power states

```sh
systemctl poweroff
systemctl reboot
systemctl suspend
systemctl hibernate
```

Other systemd daemon commands follow the same `ctl` suffix such as
`journalctl`, `loginctl`, `hostnamectl`, `resolvctl`, `networkctl`, etc.
_Note_: though these commands may be present on a system, it does not necessarily
mean they are being managed by systemd.

The real complexity of systemd comes from underlying concepts, dependencies,
and implementations of the various subsystems that have ballooned from the
init system.

### Units

The concept of **units** is core to systemd.
If you have ever heard someone say "everything is a file" when talking about
how Linux works, just think "everything is a unit" when talking about systemd.

I'm going to be paraphrasing the `man systemctl.unit` page, but a unit can be 11 different things.

It can be: a service, a socket, a device, a mount point, an automount point, a swap file or partition, a start-up target, a watched file system path, a timer

This may sound like lots of stuff to remember, and that's because it is, but
fortunately, this distinction is more relevant when creating units, so I will
save this topic until then.

### Targets

Another key concept is **targets** or **runlevels**.
Targets are type of unit that hold other units and they are
the way systemd organizes boot time dependencies.

This is another concept that becomes much more important when creating
unit-files, because you must think about what your process depends or requires
from the system before it can operate.

### journalctl

`journalctl` allows the viewing of logs managed by systemd.
