#!/bin/sh

# Functions
DownloadPerforce() 
{
	printf "\e[31mPlease provide an ftp link to the perforce version you would like to install.\e[39m\nYou can find them here: ftp://ftp.perforce.com/perforce/"
	printf "\nOr press enter to use the following version: ftp://ftp.perforce.com/perforce/r19.1/bin.linux26x86_64/"

	printf "\n\e[32m------------------- Input Section -------------------\e[39m\n"
	read sourceVar
	if [ -z "$sourceVar" ]
	then
		sourceVar=ftp://ftp.perforce.com/perforce/r19.1/bin.linux26x86_64/

	fi
	printf "\n\e[32m---------------- End of Input Section ---------------\e[39m"
	printf "\n\e[31mYou chose to install: \n$sourceVar\e[39m"
	wget $sourceVar'p4d'
	chmod +x p4d
	wget $sourceVar'p4'
	chmod +x p4
	sudo mv p4d /usr/local/bin
	sudo mv p4 /usr/local/bin
}

CreateUser()
{
	printf "\n\e[31m\nCreating a new User called Perforce as a security measure.\nPlease provide a password for the new user!\e[39m"
	sudo adduser perforce --gecos "First Last,RoomNumber,WorkPhone,HomePhone"
}

CreateDepot()
{
	printf "\n\e[31mChoose a path for the depot. Or press enter to use /p4depot as the depot root path.\e[39m"
	printf "\n\e[32m------------------- Input Section -------------------\e[39m\n"
	read depotPath
	if [ -z "$depotPath" ]
	then
		depotPath="/p4depot"
	fi
	printf "\n\e[32m---------------- End of Input Section ---------------\e[39m"

	printf "\n\e[31mCreating Depot at path: \n$depotPath\e[39m"

	sudo mkdir $depotPath
	sudo chown perforce $depotPath
}
CreateLog()
{
	printf "\n\e[31mCreating Log Folder at path: \n/var/log/perforce\e[39m"
	sudo mkdir /var/log/perforce
	sudo chown perforce /var/log/perforce
}
SetupAutostart()
{
	printf "\n\e[31mCreating automatic startup script\e[39m"
	echo "/usr/local/bin/p4d -r $depotPath -J /var/log/p4d.log" > "PerforceAutoStartServer"
	chmod +x PerforceAutoStartServer
	sudo mv PerforceAutoStartServer /usr/local/bin
	printf "\n\e[31mCreating cronjob that runs the startup script on reboot\e[39m"
	echo "@reboot /usr/local/bin/PerforceAutoStartServer" > "PerforceCronJob"
	chmod +x PerforceCronJob
	sudo mv PerforceCronJob /etc/cron.d/
}

Finished()
{
	printf "\n\e[32m
	Finished setup. Please follow the guide to finish the setup	\e[39m\n
	Your Server will now reboot. Perforce should start automatically after the reboot.	\e[39m\n"
	read -s -r -p "Press any key to continue"
}

Reboot()
{
	printf "\n\nReboot in 5..."
	sleep 1
	printf "\nReboot in 4..."
	sleep 1
	printf "\nReboot in 3..."
	sleep 1
	printf "\nReboot in 2..."
	sleep 1
	printf "\nReboot in 1..."
	sleep 1
	sudo reboot
}

# Human readable process
DownloadPerforce
CreateUser
CreateDepot
CreateLog
SetupAutostart
Finished
Reboot