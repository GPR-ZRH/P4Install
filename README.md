
# P4Install - Simple Perforce Helix setup
```html
<p color="#FF0000">Test</p>
<span style="color:blue">some *blue* text</span>
```

P4Install provides a semi-automated way to install Perforce Helix on linux based servers and NAS (such as DiskStation).

This repository provides guides and scripts that will help you get a Perforce Server up an running within minutes. You will be guided through the use of the scripts with code snippets and a step-by-step guide. The Master branch provides the main functionality of P4Install. Checkout other Branches for specfic server providers or tools. 
While it would be possible to create an fully automated script, this semi-automated way is more customizable and future proof. It allows you to manually specify which version to install, where to place the depot and increases security by seperating the perforce server from the root user.


## Generic step-by-step guide
### 0. Prerequisites
 - [ ]  Server IP address
 - [ ] Password for the root user (and username if not root)
 - [ ]  A Password for the perforce user that will be created
 - [ ]  The absolute path to where the perforce depot should be placed.
 - [ ]  PuTTY https://www.putty.org

### 1. Connect to server
 - [ ]  Start PuTTY
 - [ ] Fill in your servers IP address, port should be 22 (ssh default port) but there is a possibility it needs to be changed (should be provided by server provider if different. In home server or NAS setups it depends on your port forwarding rules)
 - [ ] Sign in as a user with root privileges

### 2. Install Perforce

    wget 
