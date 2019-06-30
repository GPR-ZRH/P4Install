#!/bin/sh

p4 set P4PORT=localhost:1666
p4 configure set dm.user.noautocreate=2
p4 configure set run.users.authorize=1
p4 configure set dm.keys.hide=2

printf "Select a security level for your server: 0 (no password), 1 (any password), 2 (strong password), 3 (Ticket based) \nMore: https://www.perforce.com/manuals/p4sag/Content/P4SAG/DB5-49899.html \n"
declare -i secLevel=-1
while [ true ]
do
	read secLevel
	if (( $secLevel > -1 && $secLevel < 7 ))
		then
			break
	else
		printf "Invalid input, try again\n"
	fi
done
p4 configure set security=$secLevel
printf "Security level set to $secLevel\n"
if (( $secLevel > 0 && $secLevel < 3 ))
	then
	printf "Provide a minimum password length (at least 8 characters recommended)\nPress \e[32mEnter\e[39m to use the default value of 12 characters.\nAccepted range is 6-1024 characters.\n"
	declare -i pwdLength=0
	while [ true ]
		do
			read pwdLength
			if (($pwdLength >= 6 && $pwdLength <= 1024 ))
			then
				break
			else
				printf "Invalid input, try again\n"
			fi
		done
	p4 configure set dm.password.minlength=$pwdLength
	printf "Password length set to $pwdLength characters.\n"
fi

printf "\n\e[32m\nFinished security setup. Please return to the guide to finish the setup	\e[39m\n"