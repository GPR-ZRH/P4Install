#!/bin/bash

printf "\e[31mPlease enter the name of your volume as presented on the digitalocean website -> Droplets -> Volumes\e[39m\n"
printf "\e[31mDO NOT COPY! Write it.. copy and paste may introduce errors if line endings get copied too.\e[39m\n"
volumeName=""

read volumeName

printf "Create a mount point for your volume at /mnt/$volumeName\n"
mkdir -p "/mnt/$volumeName"

# Mount your volume at the newly-created mount point:
mount -o discard,defaults,noatime "/dev/disk/by-id/scsi-0DO_Volume_$volumeName" "/mnt/$volumeName"

# Change fstab so the volume will be mounted after a reboot
echo "/dev/disk/by-id/scsi-0DO_Volume_$volumeName /mnt/$volumeName ext4 defaults,nofail,discard 0 0" | sudo tee -a /etc/fstab

printf "\e[32mFinished setting up your volume. You may now proceed if no errors were thrown.\e[39m\n"