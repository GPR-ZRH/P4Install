
# P4Install - Simple Perforce Helix installation
**Work in progress  may not yet work flawlessly - please search the issues or create a new one if you experience a problem**

**This guide has been tested on 01. of July 2019. While it worked fine for me, it's still not garantueed to work for everyone. Please let me now if you run into trouble.**

P4Install provides a semi-automated way to install Perforce Helix on linux based servers and NAS (such as DiskStation).

This repository provides guides and scripts that will help you get a Perforce Server up an running within minutes. You will be guided through the use of the scripts with code snippets and a step-by-step guide. The Master branch provides the main functionality of P4Install. Checkout other Branches for specfic server providers or tools. 
While it would be possible to create an fully automated script, this semi-automated way is more customizable and future proof. It allows you to manually specify which version to install, where to place the depot and increases security by seperating the perforce server from the root user.


## DigitalOcean step-by-step guide

There are multiple ways to test digitalocean if you are interested.
- If you are able to get the github [student developer pack](https://education.github.com/pack) you will get 50$ in credits.
- If you can not get the student dev pack, you will be able to get 50$ (this credit only lasts 30 days and remaining credit will be removed, charging your paypal or credit card) by using a referral link: https://m.do.co/c/eacbb4c312b4
This is my referral link and I will also get awarded 25$ in credits. I do not like to post such a link on a github repository, but I was not able to find a different way to provide the 50$ test credit without using any referral link. If anyone got a different method let me know so I can remove the referral link.
- Directly (most likely) without any free credits: https://cloud.digitalocean.com/registrations/new

You will not need a cpu and ram heavy machine to run perforce. 1-2 shared CPU cores and 1-2 GB of Ram are easily enough. I would recommend to not place the depot on the droplets harddisk, but rather adding a volume and place it there. This will give you the ability to increase the harddisks size later on if you run out of storage.

If your projects are not large in size, you can get away really cheap. We are talking about 5$ per month for the server with 25 GB and 1TB Bandwith and additional 10$ per 100GB per month if you need more disk space.

### 0. Prerequisites
 - Server IP address
 - Password for the root user (and username if not root)
 - A Password for the perforce user that will be created
 - The absolute path to where the perforce depot should be placed.
 - PuTTY https://www.putty.org
 - Helix Core Apps
	- P4V
	- P4Admin
	- P4 (Command Line Interface)

### 1. Connect to server
 - Start PuTTY
 - Fill in your servers IP address, port should be 22 (ssh default port) but there is a possibility it needs to be changed (should be provided by server provider if different. In home server or NAS setups it depends on your port forwarding rules)
 - Sign-in as a user with root privileges

![PuTTY Main Window](/docs/images/Putty.png)

 If you do not want your depot to be placed on the droplets main disk but rather on a seperate volume (Which exists seperately from the droplet itself), then execute the following code and follow the instructions presented to you by the script.
 It will ask you for the name of the volume you would like to use. So you need to create the volume beforehand on the DigitalOcean website.
 This script does the same as you could do manually by clicking here:

![DigitalOcean volume config](/docs/images/DO_VolumeConfig.png)

```
wget https://raw.githubusercontent.com/GPR-ZRH/P4Install/digitalocean/MountVolume.sh
chmod +x MountVolume.sh
./MountVolume.sh
```
![DigitalOcean droplet view](/docs/images/DO_DropletView.png)

### 2. Install Perforce
When using a linux distro that has wget installed.

```
wget https://raw.githubusercontent.com/GPR-ZRH/P4Install/digitalocean/PerforceInstall.sh
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

### 3. Create a Perforce superuser
After the server reboot. You will be able to login to your server using P4V or P4Admin.
- Start P4Admin
- Enter the server IP address followed by :1666 (Format Example: `0.0.0.0:1666`)
- Press Alt + N followed by Enter or click on the new... button next to the user field.
- A Window should pop-up requesting information to create the new user.
- When finished, click connect

![P4Admin Connect Window](/docs/images/P4Admin_AddUser.png)

![P4Admin Create User Window](/docs/images/P4Admin_AddUser2.png)

If you already have other perforce servers setup in P4Admin and you find yourself in the main view, press ctrl + O to open a new connection.

You will see yet another window pop-up clarifying that this user will become the sole superuser (Administrator / All rights)
- Accept
- Add any user you would like, create groups, assign permissions, etc.
![Perforce sole superuser window](/docs/images/P4Admin_SoleSuperuser.png)

### 4. Security measures
Perforce in its default configuration will allow anyone with access to the server (knowing the IP address) to create a new user.
Connect to the server again using PuTTY (Your previous connection went inactive when the server rebooted).
Login as before and run the following:

```
wget https://raw.githubusercontent.com/GPR-ZRH/P4Install/digitalocean/PerforceSecurity.sh
chmod +x PerforceSecurity.sh
./PerforceSecurity.sh	
```
This will disallow automatic user creation, viewing of the available users and viewing of the configs.
It will also ask you to decide upon the use of passwords vs tickets and if applicaple the password strength.

### 5. Enjoy
Have fun :)
Check out the other branches if you need your server to be setup in a specific way (for example to host Unreal Engine 4 Projects).
