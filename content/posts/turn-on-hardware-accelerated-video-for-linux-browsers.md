---
title: "Turn on Hardware Accelerated Video for Chrome/Firefox on Linux"
date: 2020-11-12T12:51:47-05:00
draft: true
toc: false
images:
tags:
  - chrome
  - chromium
  - firefox
  - video
  - acceleration
---

## Chrome

1. Open chrome and go type `chrome://flags` in the address bar.

2. Search for **"video decode"**

3. Change **"Hardware-accelerated video decode"** from "Disabled" to "Enabled"

![chrome_scrnshot](/images/posts/browser-hardware-acceleration/chrome_ha.png)

Another way to enable these flag features is creating a config file called
`~/.config/chrome-flags.conf` for chrome or `~/.config/chromium-flags.conf`
for chromium.

For example here is mine:

```sh
~ $ cat ~/.config/chromium-flags.conf
--ignore-gpu-blocklist
--enable-gpu-rasterization
--enable-zero-copy
--use-gl=desktop
--enable-accelerated-video-decode
```

## Firefox

1. Open firefox and type `about:config` in the address bar.

2. Click "Accept the Risk and Continue" (don't worry the risk here is very minimal)

3. Search for **"vaapi"**

4. Change **"media.ffmpeg.vaapi.enable"** from false to true.

![firefox_scrnshot](/images/posts/browser-hardware-acceleration/firefox_ha.png)

## What is hardware acceleration

Hardware acceleration refers to using a GPU to render/playback video rather
than the CPU.

Almost all user-facing computers these days have a GPU of some sort.
Laptop CPUs often have "integrated graphics", which means there is a portion
of the chip specifically designed for graphics output.
On desktops, there can also be "integrated graphics" built into the motherboard.
Then there is discrete or dedicated graphics, which is an external standalone card.

## Why is it disabled by default on Linux

On Windows and MacOS, hardware acceleration on browsers is enabled by default
and works fine out the box, so why is this not the case on Linux?

**IMO:** The reasons for doing this come from the support and engineering side
more than the technical implementation -- which has been largely finished
since 2017. There are plenty of hardware-accelerated programs that run fine on
Linux, but they add much more complexity when something breaks.

Enabling this by default could definitely break video playback for some users
and cause other issues that would be costly for engineers to troubleshoot/debug/fix.

As a result, these "extra features" are often hidden behind a flag and tagged as
experimental, even though they are probably stable enough for the majority
of users.

### Additional Sources:

- [Chromium - Arch Wiki](https://wiki.archlinux.org/index.php/Chromium#Force_GPU_acceleration)

- [List of chromium flags](https://peter.sh/experiments/chromium-command-line-switches/)

- [Firefox GPU Acceleration](https://www.omgubuntu.co.uk/2020/08/firefox-80-release-linux-gpu-acceleration)
