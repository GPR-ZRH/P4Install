# P4Install
Semi-automated way to install Perforce Helix on linux based servers and NAS



## Generic step-by-step guide
### 0. Prerequisites
- Server IP address
- Password for the root user (and username if not root)
- A Password for the perforce user that will be created
- The absolute path to where the perforce depot should be placed.
- PuTTY https://www.putty.org

### 1. Connect to server
- Start PuTTY
- Fill in your servers IP address, port should be 22 (ssh default port) but there is a possibility it needs to be changed (should be provided by server provider if different. In home server or NAS setups it depends on your port forwarding rules)
- sign is as a user with root privileges

### 2. Install Perforce

