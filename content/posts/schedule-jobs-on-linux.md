---
title: "Schedule Jobs on Linux"
date: 2020-07-21T01:47:17-04:00
draft: false
toc: false
images:
tags:
  - cron
  - Linux
  - schedule
  - timer
  - jobs
---

If you want to schedule a program to run on a Unix based OS, there are
a handful of options, but the prominent ones found on Linux are
cron and systemd timers.

Initially released in 1975, `cron` has stood the test of time when it comes
to running a task on a schedule and it continues to be the standard solution
for all kinds of users.

## How does it work

There is a file called `crontab` which tells the cron daemon what to run
and when to run it.

### Daemons

There are several cron daemons out there and the default one will depend
on what distro your using, but they all understand the same crontab, which
is what ends up getting executed in the end.
The [cron package](https://wiki.archlinux.org/index.php/cron#Cronie)
on Arch is called `cronie` or just [`cron`](https://packages.debian.org/buster/cron)
on Debian based distros.

### Crontab

The system crontab file, is found at `/etc/crontab`, but there is also a place
where users can create their own crontab file by using `crontab -e`.

The system crontab does require you to specify which user to run the command as
whether that be root or someone else.

On my system, the user crontabs are stored in the `/var/spool/cron/`
directory in a file with the same name as \$USER.

#### Syntax

An overview of the syntax is as follows:

There are five fields you must specify:

minute, hour, day, month, day of the week.

```text
┌───────────── minute (0 - 59)
│ ┌───────────── hour (0 - 23)
│ │ ┌───────────── day of the month (1 - 31)
│ │ │ ┌───────────── month (1 - 12)
│ │ │ │ ┌───────────── day of the week (0 - 6) (Sunday to Saturday;
│ │ │ │ │                                   7 is also Sunday on some systems)
│ │ │ │ │
│ │ │ │ │
* * * * * command to execute
```

So running something every hour would be done like this:

```text
0 * * * *	echo "hourly job"
```

To run something every minute you can do:

```text
* * * * *	echo "minute job"
```

And to run something every day you can do:

```text
* 0 * * *	echo "day job"
```

etc.

You can also specify ranges with a `-`, steps with a `/`, and use `,` as a separator

An example using all:

```text
*/30 9-17 * * 1,5
```

In English:

Every 30 minutes past every hour from 9:00-5:00 on Monday and Friday.

### Other tools

It can get a bit confusing if you have a complicated set of times you wish to run a certain program.

A site I would recommend is <https://crontab.guru/>, which puts this syntax in
plain English and has some common examples to use. As always the archwiki is
a great resource for this kind of thing.

One thing to note is `cron` expects a system to be persistent and always on,
meaning if your machine is down for whatever reason, the job will _not_ be run
when it is booted back up. To combat this, `anacron` was created and that is
what many desktop distributions use along with `cron`.

### Check jobs and logs

As a user, to see what's in your crontab, you can run `crontab -l`.

One way to check if what cron tasks were run or not is to check the log.

On a box running systemd, you can use `journalctl -u <cron daemon>`
to check out the logs, which should report any jobs that were run.

## Anacron

The syntax and functionality of `anacron` is different from `cron`, but it
mostly serves the same purpose which is to run a task periodically.

The default anacrontab looks very similar to a crontab with some
minor differences.

```text
# /etc/anacrontab: configuration file for anacron

# See anacron(8) and anacrontab(5) for details.

SHELL=/bin/sh
PATH=/sbin:/bin:/usr/sbin:/usr/bin
MAILTO=root
# the maximal random delay added to the base delay of the jobs
RANDOM_DELAY=45
# the jobs will be started during the following hours only
START_HOURS_RANGE=3-22

#period in days   delay in minutes   job-identifier   command
1	5	cron.daily		nice run-parts /etc/cron.daily
7	25	cron.weekly		nice run-parts /etc/cron.weekly
@monthly 45	cron.monthly		nice run-parts /etc/cron.monthly
```

With `anacron`, there are shortcuts for common periods of time.
Like @monthly shown in the example, there is also @daily, @weekly, and so on.

In this file you can also see `run-parts` being used to run all the scripts
in certain `/etc/cron.*` directories. This means that instead of creating a special
entry in a crontab, a user can simply place a script in one of these directories
and it will be run as the name suggests.

## Time Resolution

A minute is the shortest measure of time in cron, as opposed to systemd timers,
which can handle seconds, milliseconds, and nanoseconds.

Of course there are other daemons that can handle this kind of task.
And there is always the opportunity to write one :)

A commonplace solution is systemd-timers because systemd is more or less the
default init system for most Linux distros.

## Systemd timers

Checking on what timers are enabled on a system is done with:

```sh
$ systemctl list-timers

NEXT                        LEFT     LAST                        PASSED       UNIT                         ACTIVATES
Tue 2020-07-21 15:08:22 EDT 12h left Mon 2020-07-20 14:05:40 EDT 12h ago      systemd-tmpfiles-clean.timer systemd-tmpfiles-clean.service
Wed 2020-07-22 00:00:00 EDT 21h left Tue 2020-07-21 00:00:01 EDT 2h 15min ago atop-rotate.timer            atop-rotate.service
Wed 2020-07-22 00:00:00 EDT 21h left Tue 2020-07-21 00:00:01 EDT 2h 15min ago man-db.timer                 man-db.service
Wed 2020-07-22 00:00:00 EDT 21h left Tue 2020-07-21 00:00:01 EDT 2h 15min ago shadow.timer                 shadow.service

4 timers listed.
Pass --all to see loaded but inactive timers, too.
```

A systemd .timer unit file is usually associated with a .service unit.

Let's look at a timer unit file. The `man-db.timer` is located at `/usr/lib/systemd/system/man-db.timer` on my system.

```ini
# man-db.timer

[Unit]
Description=Daily man-db regeneration
Documentation=man:mandb(8)

[Timer]
OnCalendar=daily
AccuracySec=12h
Persistent=true

[Install]
WantedBy=timers.target
```

Note the `WantedBy=timers.target` and the time directives under `[Timer]`
like `OnCalendar=` and `AccuracySec=`. Systemd gives more directives
for controlling when a service runs. `man systemd.timers` [also online](https://jlk.fjfi.cvut.cz/arch/manpages/man/systemd.timer.5) is the best
resource to find this out.

This unit file only describes when to run a job, but now _how_. That is
the purpose of a service file (`/usr/lib/systemd/system/man-db.service` in this case).

```ini
# man-db.service

[Unit]
Description=Daily man-db regeneration
Documentation=man:mandb(8)
ConditionACPower=true

[Service]
Type=oneshot
# Recover from deletion, per FHS.
ExecStart=+/usr/bin/install -d -o root -g root -m 0755 /var/cache/man
# Expunge old catman pages which have not been read in a week.
ExecStart=/usr/bin/find /var/cache/man -type f -name *.gz -atime +6 -delete
# Regenerate man database.
ExecStart=/usr/bin/mandb --quiet
User=root
Nice=19
IOSchedulingClass=idle
IOSchedulingPriority=7
```

Here we can see what the service is actually running with `ExecStart=` and
some other details of how the processes get run, including `User=` and
`Nice=`. This is a pretty common looking service file, the main difference
being that it gets run from a timer, and not at one of the boot time run
levels.

## Cron or Systemd

Well, I think there is a case for either one depending on the situation.
If you already have a unit file made for your script/program, it would
be rather easy to run it by creating and enabling a systemd timer.

Cron does have the advantage of simplicity and ease of use -- although that
is debatable depending on how you feel about the syntax.
Not requiring the user to create extra files to schedule running things
is very powerful, and all it requires is knowing the 5 \*'s and some
of the caveats of the crontab.
