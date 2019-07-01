#!/bin/bash

# Functions
DownloadPerforce() 
{
	printf "\e[31mPlease provide an ftp link to the perforce version you would like to install.\e[39m\nYou can find them here: ftp://ftp.perforce.com/perforce/"
	printf "\nOr press \e[32mEnter\e[39m to use the following version: ftp://ftp.perforce.com/perforce/r19.1/bin.linux26x86_64/"

	printf "\n\e[32m------------------- Input Section -------------------\e[39m\n"

	while [ true ]
	do
		read sourceVar
		if [ -z "$sourceVar" ] || [ ${#sourceVar} -lt 7 ] 
		then
			sourceVar=ftp://ftp.perforce.com/perforce/r19.1/bin.linux26x86_64/
			break
		else
			printf "Invalid Input. Try again!\n"			
		fi
	done

	printf "\n\e[32m---------------- End of Input Section ---------------\e[39m"
	printf "\n\e[31mYou chose to install: \n$sourceVar\e[39m\n"
	wget $sourceVar'p4d'
	chmod +x p4d
	wget $sourceVar'p4'
	chmod +x p4
	sudo mv p4d /usr/local/bin
	sudo mv p4 /usr/local/bin
}

CreateUser()
{
	printf "\n\e[31m\nCreating a new User called Perforce as a security measure.\nPlease provide a password for the new user!\e[39m\n"
	sudo adduser perforce --gecos "First Last,RoomNumber,WorkPhone,HomePhone"
}

CreateDepot()
{
	printf "\n\e[31mChoose a path for the depot. Or press enter to use /p4depot as the depot root path.\e[39m"
	printf "\n\e[32m------------------- Input Section -------------------\e[39m\n"
	read depotPath
	if [ -z "$depotPath" ] || [ ${#depotPath} -lt 3 ]
	then
		depotPath="/p4depot"
	else
	firstChar="${depotPath:0:1}"
		if [ $firstChar != "/" ]
		then
			depotPath="/"$depotPath
		fi
		
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
	echo "@reboot root /usr/local/bin/PerforceAutoStartServer" > "PerforceCronJob"
	chmod +x PerforceCronJob
	sudo mv PerforceCronJob /etc/cron.d/
}

Finished()
{
	printf "\n\e[32m\nFinished setup. Please follow the guide to finish the setup\e[39m\n"
	printf "\e[32mYour Server will now reboot. Perforce should start automatically from now on.\e[39m\n"
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