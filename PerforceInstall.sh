#!/bin/sh

echo "Please provide an ftp link to the perforce version you would like to install. You can find them here: ftp://ftp.perforce.com/perforce/"
echo "Or press enter to use the following version: ftp://ftp.perforce.com/perforce/r19.1/bin.linux26x86_64/"
echo "------------------- Input Section -------------------"
read sourceVar
if [ -z "$sourceVar" ]
then
	sourceVar=ftp://ftp.perforce.com/perforce/r19.1/bin.linux26x86_64/
fi
echo "---------------- End of Input Section ---------------"
echo $sourceVar'p4d'
wget $sourceVar'p4d'
chmod +x p4d
wget $sourceVar'p4'
chmod +x p4
sudo mv p4d /usr/local/bin
sudo mv p4 /usr/local/bin
sudo adduser perforce

echo "Choose a path for the depot. Or press enter to use /p4depot as the depot root path."
echo "------------------- Input Section -------------------"
read depotPath
if [ -z "$depotPath" ]
then
	depotPath="/p4depot"
fi
echo "---------------- End of Input Section ---------------"

echo $depotPath
sudo mkdir $depotPath
sudo chown perforce $depotPath
sudo mkdir /var/log/perforce
sudo chown perforce /var/log/perforce

fullDepotPath="$PWD""$depotPath"
echo $fullDepotPath

echo "/usr/local/bin/p4d -r $fullDepotPath -J /var/log/p4d.log" > "PerforceAutoStartServer"
chmod +x PerforceAutoStartServer
sudo mv PerforceAutoStartServer /usr/local/bin

echo "@reboot /usr/local/bin/PerforceAutoStartServer" > "PerforceCronJob"
chmod +x PerforceCronJob
sudo mv PerforceCronJob /etc/cron.d/

# Obsolete ?
#echo "The following command might throw warnings or errors. If so, proceed as normal and check whether everything runs fine at the end."
#sudo apt-get install daemon
# One possible way to do it.
#cd /etc/init.d
#wget p4AutoStartServ
#chmod +x /etc/init.d/p4AutoStartServ
#sudo update-rc.d p4AutoStartServ defaults

echo "Your Server will now reboot. Perforce should start automatically after the reboot."
echo "Reboot in 5..."
sleep 1
echo "Reboot in 4..."
sleep 1
echo "Reboot in 3..."
sleep 1
echo "Reboot in 2..."
sleep 1
echo "Reboot in 1..."
sleep 1
sudo reboot