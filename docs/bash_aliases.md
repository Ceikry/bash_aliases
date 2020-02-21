TangoMan bash_aliases documentation
===================================

bash_files
----------

### open

Open file or folder with appropriate app

### clear-chrome-cache

kill google chrome process and clear cache on linux

### urlencode

Decode string from URL format

### urldecode

Encode string to URL format

### cc

```bash
'clear'
```

clear terminal

### ccc

```bash
'clear && history -c'
```

clear terminal & history

### h

```bash
'echo_info "history"; history'
```

history

### hh

```bash
'echo_info "history|grep"; history|grep'
```

search history

### hhh

```bash
'cut -f1 -d" " ~/.bash_history|sort|uniq -c|sort -nr|head -n 30'
```

print most used commands

### ll

```bash
'echo_info "ls -lFh"; ls -lFh'
```

list non hidden files human readable

### lll

```bash
'echo_info "ls -alFh"; ls -alFh'
```

list all files human readable

### mkdir

```bash
'mkdir -p'
```

create necessary parent directories

### trim

```bash
"sed -E 's/^[[:space:]]*//'|sed -E 's/[[:space:]]*$//'"
```

trim given string

### tt

```bash
'echo_info "gnome-terminal --working-directory=`pwd`"; gnome-terminal --working-directory=`pwd`'
```

open current location in terminal

### unmount

```bash
'umout'
```

unmout

### xx

```bash
'exit'
```

disconnect

### echo_box

Print formatted text inside box with optional title, footer and size (remove indentation)

### echo_error

Print error message (red text prefixed with bold "error: ")

### echo_label

Print label with tabulation (bold green, no line break)

### echo_prompt

Print prompt (cyan, no line break)

### echo_title

Print title (bold white text over red backgound)

### echo_caption

Print caption (bold white text over blue backgound)

### echo_bold

Print bold (bold blue)

### echo_danger

Print danger (red text)

### echo_success

Print success (green text)

### echo_warning

Print warning (yellow text)

### echo_secondary

Print secondary (blue text)

### echo_info

Print info (magenta text)

### echo_primary

Print primary (cyan text)

git
---

### merge

Merge git branch into current branch

### push

Update remote git repository

### greset

Reset current git history

### guser

Print / update git account identity

### config

Set bash_aliases git global settings

### amend

```bash
'git commit --amend'
```

amend last commit

### cdgit

```bash
'toplevel'
```

jump to project top level folder

### current

```bash
'echo "$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"'
```

print current branch name

### diff

```bash
'gdiff'
```

git diff

### fetch

```bash
'git fetch --all'
```

fetch all branches

### gst

```bash
'dashboard'
```

print git dashboard

### latest-sha

```bash
'git rev-parse --verify HEAD'
```

print latest commit sha

### lb

```bash
'lbranches'
```

list branches

### log

```bash
'git log --graph --stat'
```

print full git log

### previous-sha

```bash
'git rev-parse --verify HEAD^1'
```

print previous commit sha

### repository-name

```bash
'echo $(git remote get-url origin|sed -E "s/(http:\/\/|https:\/\/|git@)//"|sed -E "s/\.git$//"|tr ":" "/"|cut -d/ -f3)'
```

print remote repository name

### repository

```bash
'echo "$(basename `git rev-parse --show-toplevel` 2>/dev/null)"'
```

print current toplevel folder name

### undo

```bash
'git checkout -- .'
```

remove all changes

### what

```bash
'git whatchanged -p --abbrev-commit --pretty=medium'
```

print changes from every commit

### add

Stage files to git index

### lbranches

List local git branches

### remote

Set / print local git repository server configuration

### branch-exists

Check if git branch exists

### bitbucket

Create new private git repository on bitbucket

### init

Initialize git repository

### gdiff

Print changes between working tree and latest commit

### gstatus

Print git status

### tag

Create, list or return latest tag

### backup

Backup current local repository to remote server

### branch

Create, checkout, rename or delete git branch

### list-bitbucket

Lists private repositories from bitbucket

### pull

Fetch from remote repository to local branch

### rebase

Clean local commit history

### clone

Clone remote git repository to local folder

### lremote

List remote git branches

### dashboard

Print git dashboard

### commit

Write changes to repository, or rename last commit

security
--------

### change-mac-address

Spoof network adapter mac address

### wifi-fakeauth

Associates with target wifi network

### wifi-sniff

Dump captured packets from target adapter

### wifi-deauth

Disconnect client from wifi network

### reverse-shell

Create a reverse shell connection

network
-------

### unmount-nfs

mount nfs share into /media/nfs

### check-dns

Check DNS records

### iptables-port-redirect

Redirect ports with iptables

### python-server

Starts python built-in server

### quick-scan

Quick scan local network with nmap

### myip

```bash
'echo_info "curl -s https://api.ipify.org"; echo "`curl -s https://api.ipify.org`\n"'
```

Get ip from ipify.org

### local-ip

```bash
'echo_info "hostname -I"; hostname -I'
```

Print ip

### open-ports

```bash
'echo_info "lsof -i -Pn | grep LISTEN"; lsof -i -Pn | grep LISTEN'
```

List open ports

### close-ssh-tunnels

```bash
'sudo pkill ssh'
```

Close all ssh tunnels

### find-ssh-process

```bash
'ps aux | grep ssh'
```

find ssh processes

### hosts

```bash
'sudo subl /etc/hosts'
```

edit hosts with sublime

### list-ssh

```bash
'netstat -n --protocol inet | grep :22'
```

list open ssh connections

### mac

```bash
'ifconfig | grep HWaddr'
```

print mac address

### mysql-start

```bash
'sudo /etc/init.d/mysql start'
```

start mysql server

### mysql-stop

```bash
'sudo /etc/init.d/mysql stop'
```

stop mysql server

### resolve

```bash
'host'
```

resolve reverse hostname

### iptables-list-rules

```bash
'echo_info "sudo iptables -S"; sudo iptables -S; echo_info "sudo iptables -L"; sudo iptables -L'
```

list iptables rules

### wifi-get-bssids

Print available bssids, channels and ssids

### wifi-radar

Discover available wireless networks

### wifi-managed-mode

Set wlan adapter to managed mode

### unset-hosts

Comment out desired host from /etc/hosts

### php-server

Starts php built-in server

### set-php-version

set default php version

### wifi-monitor-mode

Set wlan adapter to monitor mode

### port-scan

Scan ports with nmap

### mount-nfs

mount nfs share into /media/nfs

### set-hosts

set your /etc/hosts

### ping-scan

Ping scan with nmap

web
---

### google

Search on google.com

### github

Search on github.com

### lmgtfy

Let me google that for you search

### giphy

Search on giphy.com

### trends

Search on google trends

### youtube

Search on youtube.com

### gg

```bash
'google'
```

google

### gh

```bash
'github'
```

github

### gif

```bash
'giphy'
```

giphy

### yt

```bash
'youtube'
```

youtube

utils
-----

### search

Find file in current directory

### compress

Compress a file, a folder or each subfolders into separate archives recursively with 7z

### archive

Compress / extract tar archive

### size

Print total size of file and folders

### picture-rename-to-datetime

Rename pictures to date last modified (creates undo script)

### rename-script-generator

Generate rename script in current folder

### decode

Decode string from base64 format

### promt-user

Prompt user for parameter

### picture-update-datetime

Update picture modified at from filename (creates undo script)

### create-desktop-shortcut

Create a shortcut on user destop

### extract-archives

Extract each archive to destination

### picture-organize

Organise picture and videos by last modified date into folders (creates undo script)

### move-all-files-here

Move all files from subfolders ibto current folder

### clean-folder

recursively delete junk from folder

### encode

Encode string from base64 format

### random-string

Generate random string

### rename

Rename files from given folder (creates undo script)

### help

Print help for desired option

### picture-list-exif

Lists picture exif modified at

### strreplace

Search and replace string from files

### exists

Check if program is installed, and command or function exists

system
------

### bootable-iso

Create bootable usb flash drive from iso file or generate iso file from source

### pkg-remove

Shortcut for apt-get remove -y

### pkg-installed

Find / list installed apt packages

### pkg-list

Find / list available apt packages

### pkg-install

Install package on multiple systems

### own

Own files and folders

### drives

list connected drives

### systemct-list

```bash
'systemctl list-unit-files | grep enabled'
```

List enabled services

### disks

```bash
'drives'
```

List devices

### devices

```bash
'drives'
```

List devices

### check-codename

Check linux codename

### create-user

Create new user

### pkg-search

Find / list available apt packages

tangoman
--------

### tango-reload

Reload aliases (after update)

### tango-doc

Print bash_aliases documentation

### tango-info

Print current system infos

### tango-update

Update tangoman bash_aliases

symfony
-------

### tests

Perform php-unit tests

### sf

Returns appropriate symfony console location

### rebuild

Creates symfony var/cache, var/logs, var/sessions

### symfony-server

Starts symfony built-in server

### cache

```bash
'sf cache:clear --env=prod'
```

clears the cache

### router

```bash
'sf debug:router'
```

debug router

### schema-update

```bash
'sf doctrine:schema:update --dump-sql --force'
```

update database shema

### services

```bash
'sf debug:container'
```

debug container

### warmup

```bash
'sf cache:warmup --env=prod'
```

warms up an empty cache

### installer

```bash
'php -r "file_put_contents(\"symfony\", file_get_contents(\"https://symfony.com/installer\"));"'
```

download symfony installer with php

### nuke

Removes symfony cache, logs, sessions and vendors

multimedia
----------

### play

Play folder with vlc

