
# P4Install - Simple Perforce Helix 
**Work in progress**

P4Install provides a semi-automated way to install Perforce Helix on linux based servers and NAS (such as DiskStation).

This repository provides guides and scripts that will help you get a Perforce Server up an running within minutes. You will be guided through the use of the scripts with code snippets and a step-by-step guide. The Master branch provides the main functionality of P4Install. Checkout other Branches for specfic server providers or tools. 
While it would be possible to create an fully automated script, this semi-automated way is more customizable and future proof. It allows you to manually specify which version to install, where to place the depot and increases security by seperating the perforce server from the root user.


## Generic step-by-step guide
### 0. Prerequisites
 - Server IP address
 - Password for the root user (and username if not root)
 - A Password for the perforce user that will be created
 - The absolute path to where the perforce depot should be placed.
 - PuTTY https://www.putty.org
 - Helix Visual Client (P4V)
       - P4V
       - P4Admin
       - P4 (Command Line Interface)

### 1. Connect to server
 - Start PuTTY
 - Fill in your servers IP address, port should be 22 (ssh default port) but there is a possibility it needs to be changed (should be provided by server provider if different. In home server or NAS setups it depends on your port forwarding rules)
 - Sign in as a user with root privileges

### 2. Install Perforce
When using a linux that has wget installed.

```
    wget public-URL-to-InstallScript
    chmod +x PerforceInstall.sh
    ./PerforceInstall.sh
```

If wget is not installed try the following:

```
    apt-get install wget
```

or:

```
    yum install wget
```

Follow the instructions given by the script. Important information is written in red.

### 3. Create a Perforce Administrator User
After the server reboot. You will be able to login to your server using P4V or P4Admin.
- Start P4Admin
- Enter the server IP address followed by :1666 (Format Example: `0.0.0.0:1666`)
- Click on new user
- A Window should pop-up requesting information to create the new user.
- When finished, click connect

You will see yet another window pop-up clarifying that this user will become the sole super-user (Administrator / All rights)
- Accept
- Add any user you would like, create groups, assign permissions, etc.

### 4. Security measures
Perforce in its default configuration will allow anyone with access to the server (knowing the IP address) to create a new user.

