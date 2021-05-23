---
title: "Setting Up Samba on a Raspberry Pi"
date: 2021-05-22T20:12:49-04:00
draft: false
toc: false
images:
tags:
  - tutorial
  - samba
  - file server
  - nas
---

[Samba](<https://en.wikipedia.org/wiki/Samba_(software)>) is one of the go-to protocols for sharing files over a network.

It is builtin to Windows, but needs to be installed and configured on other OSes
like Linux and macOS.

Thankfully the process is not too difficult.

## Installing on Rasbian

Run the following command on your Pi to install a samba server and client onto
your Pi.

```sh
sudo apt update && sudo apt install samba samba-common-bin smbclient cifs-utils
```

## Checking the smb server

To check the status of your smb server, use:

```sh
systemctl status smbd
```

## Configuring Samba

### Making a user

Samba users are different from Unix/Linux users, so we must create a new user
with the `smbpasswd` command

```sh
sudo smbpasswd -a pi
```

It should ask for a password for the new user before adding them

### Network Shares, Permissions configuration

The main configuration file for samba is located at `/etc/samba/smb.conf`. This
is where you configure which folders/files are shared, what permissions they have (client side),
whether they are public, and more.

Let's assume you have a folder `/home/pi/share` that has files you want to share.
You can create this by doing `mkdir -m 1777 /home/pi/share`

If you wanted samba to share this directory, you would need something like this
in your `smb.conf`:

```cfg
...
[share]
   path = /home/pi/share
   writeable=Yes
   create mask=0777
   directory mask=0777
   public=no
```

Note: always make sure to restart samba after changing configurations

```sh
systemctl restart smbd
```

## Mounting a smb share on Linux

```sh
mount -t cifs -o username=pi //<ip of server>/myshare /mnt/share
```

## Mapping a smb share as a drive on Windows

### With File Explorer

1. Open File Explorer

2. Click "This PC"

3. In the ribbon view click "Map network drive"

![map-drive-1](/images/posts/setting-up-smb-on-a-raspberry-pi/map-drive.png)

4. Enter `\\<ip of server>\share` for the folder (you can do this in File Explorer too)

![map-drive-2](/images/posts/setting-up-smb-on-a-raspberry-pi/map-drive2.png)

5. Enter the user and password credentials setup earlier

6. The share should be mapped

### With CMD.exe

```cmd
net use Z: \\<ip of server>\folder
```

### With PowerShell

```powershell
New-SmbMapping -LocalPath 'Z:' -RemotePath '\\<ip of server>\folder'
```
