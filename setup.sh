###Welcome to Apache2 Adminstration Guide

###This is Module will be Responsible for Install, Uninstall, Start, Stop, Restart and CheckStatus of Apache2

###Function Responsible for install Apache2 Service
function install {
	
	#Check for Package is Installed or Not
	checkPackageInstalled "apache2"

	#Update your Mirror Packages
	sudo apt update
	
	#Install Apache2 with Full Packages Dependencies
	sudo apt install "apache2"
}

###Function Responsible for uninstall Apache2 Service
function uninstall {
	
	#Check for Package is Installed or Not
	checkPackageInstalled "apache2"

	#Uninstall Apache2 Service
	sudo apt purge "apache2"
	
	#Update your Mirror Packages
	sudo apt update
}

###Function Responsible for Start Apache2 Service
function start {

	#start Apache2 Service
	sudo service apache2 start
	
	echo "Apache2 is Working Now"
}

###Function Responsible for stop Apache2 Service
function stop {
	
	#stop Apache2 Service
	sudo service apache2 stop
	
	echo "Apache2 is Stopped"
}

###Function Responsible for Restart Apache2 Service
function restart {
	
	#restart Apache2 Service
	sudo service apache2 restart
	
	echo "Apache2 is restarted"	
}

###Function Responsible for Check Status of Apache2 Service
function checkStatus {

	#check status of Apache2 Service
	sudo service apache2 status
}

###Developed By Islam Shaaban