#!/bin/sh

p4 set P4PORT=localhost:1666
printf "\e[31mPlease provide the username of the superuser you created.\e[39m\n"
read adminUser
p4 set P4User=adminUser
printf "\e[31mYou will now be asked to provide the password of your superuser.\n\e[39mIt does not get saved on the server.\n"
p4 configure set dm.user.noautocreate=2
p4 configure set run.users.authorize=1
p4 configure set dm.keys.hide=2

printf "\e[31mSelect a security level for your server: 0 (no password), 1 (any password), 2 (strong password), 3 (Ticket based)\e[39m \nRead more at https://www.perforce.com/manuals/p4sag/Content/P4SAG/DB5-49899.html \n"

printf "\n\e[32m------------------- Input Section -------------------\e[39m\n"	
secLevel=-1
while [ true ]
do
	read secLevel
	if [ $secLevel -ge 0 ] && [ $secLevel -lt 7 ]
		then
			break
	else
		printf "Invalid input, try again\n"
	fi
done
printf "\n\e[32m---------------- End of Input Section ---------------\e[39m\n"

p4 configure set security=$secLevel
printf "\e[31mSecurity level set to $secLevel\n\n\e[39m"


if [ $secLevel -gt 0 ] && [ $secLevel -lt 3 ]
	then
	printf "\e[31mProvide a minimum password length (at least 8 characters recommended)\nPress \e[32mEnter\e[39m \e[31mto use the default value of 12 characters.\n\e[39mAccepted range is 6-1024 characters.\n"
	
	printf "\n\e[32m------------------- Input Section -------------------\e[39m\n"	
	pwdLength=0
	while [ true ]
		do
			read pwdLength
			if [ $pwdLength -ge 6 ] && [ $pwdLength -le 1024 ]
			then
				break
			else
				printf "Invalid input, try again\n"
			fi
		done
	printf "\n\e[32m---------------- End of Input Section ---------------\e[39m\n"
	p4 configure set dm.password.minlength=$pwdLength
	printf "\e[31mPassword length set to $pwdLength characters.\e[39m\n"
fi

printf "\n\e[32m\nFinished security setup. Please return to the guide to finish the setup	\e[39m\n"