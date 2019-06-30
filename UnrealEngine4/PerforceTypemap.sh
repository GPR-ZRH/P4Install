#!/bin/sh

printf "\e[31mWould you like to create a new typemap file (this will replace an existing one) or append to the existing?\n\e[39m"
printf "Enter \e[32mc\e[39m to create a new one and \e[32ma\e[39m to append to an existing typemap!\n"

depotName="depot"

GetDepotName()
{
	printf "\e[31Please provide the depot name. If nothing is provided it will asume the default depot name \'depot\'.\n\e[39m"
	printf "You can also provide the path to a folder within a depot. This will apply the settings to the specified folder only.\n"
	read depotName
}

WriteMappings()
{
	echo 
	"
                binary+S2w //$depotName/....exe
                binary+S2w //$depotName/....dll
                binary+S2w //$depotName/....lib
                binary+S2w //$depotName/....app
                binary+S2w //$depotName/....dylib
                binary+S2w //$depotName/....stub
                binary+S2w //$depotName/....ipa
                binary //$depotName/....bmp
                text //$depotName/....ini
                text //$depotName/....config
                text //$depotName/....cpp
                text //$depotName/....h
                text //$depotName/....c
                text //$depotName/....cs
                text //$depotName/....m
                text //$depotName/....mm
                text //$depotName/....py
                binary+l //$depotName/....uasset
                binary+l //$depotName/....umap
                binary+l //$depotName/....upk
                binary+l //$depotName/....udk
	" >> tmpTypemap
}

CreateTypemap()
{
	GetDepotName
	echo 
	"
# Perforce File Type Mapping Specifications.
#
#  TypeMap:             a list of filetype mappings; one per line.
#                       Each line has two elements:
#
#                       Filetype: The filetype to use on 'p4 add'.
#
#                       Path:     File pattern which will use this filetype.
#
# See 'p4 help typemap' for more information.

TypeMap:
" > tmpTypemap
	WriteMappings
	p4 typemap -i < tmpTypemap
}

AppendTypemap()
{
	WriteMappings
	p4 typemap -i << tmpTypemap
}


while [ true ]
do
	read action
	if [ "$action" == "c" ]
		then
			CreateTypemap
			break
	else if [ "$action" == "a" ]
		then
			AppendTypemap
			break
	else
		printf "Invalid input, try again\n"
	fi
done
rm tmpTypemap
printf "\n\e[32m\nFinished creating the typemap. Please return to the guide to finish the setup	\e[39m\n"