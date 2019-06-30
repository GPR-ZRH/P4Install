
# P4Install - Post setup configuration for Unreal Engine 4 projctes
**Work in progress  may not yet work flawlessly - please search the issues or create a new one if you experience a problem**

After you have installed Perforce Helix and setup your users, you are ready to go.. But wait.. there is more to it.
If you want to use your perforce server mainly for Unreal Engine 4 projects, you should properly setup .p4ignore file(s) and typemap(s).
This makes it way easier if you want do have a hassle and pain free experience (Believe me.. I learned it the hard way).

## Step-by-step configuration guide
### 0. Prerequisites
 - Server IP address
 - Password for the root user (and username if not root)
 - Username and password of your Perforce superuser
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

### 2. Install Perforce
When using a linux distro that has wget installed.

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
    wget public-URL-to-SecurityScript
    chmod +x PerforceSecurity.sh
    ./PerforceSecurity.sh
	
```
This will disallow automatic user creation, viewing of the available users and viewing of the configs.
It will also ask you to decide upon the use of passwords vs tickets and if applicaple the password strength.

### 5. Enjoy
Have fun :)
Check out the other branches if you need your server to be setup in a specific way (for example to host Unreal Engine 4 Projects).
