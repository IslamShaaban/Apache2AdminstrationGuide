###Welcome to Apache2 Adminstration Guide

###This Module will be Responsible for Configuration of Apache2 Web Services

###Function will be Responsible for Configure Port with Local Host (Server)
function portConfig {

	local PORT
		
	#Enter Port Number
	read -p "Enter New Port Number: " PORT

	checkPortNumber ${PORT}

	#Configuration of Port for your Local Host	
	sed -i '/^Listen/c\Listen '${PORT} /etc/apache2/ports.conf

	echo "Port Number Changed Successfully"

	restart
}


###Function will be Responsible for Show a List of All Virtual Hosts
function showAllVirtualHosts {

	#Show All Virtual Hosts	
	echo "This is a List of All Virtual Hosts Found"
	
	apache2ctl -S
}

###Function will be Responsible for Enable All Virtual Hosts 
function enableAllVirtualHosts {	

	#Enable All Virtual Hosts
	cd /etc/apache2/sites-available

	a2ensite *

	systemctl reload apache2
	
	restart
}

###Function will be Responsible for Disable All Virtual Hosts
function disableAllVirtualHosts {

	#Disable All Virtual Hosts
	cd /etc/apache2/sites-available
	
	a2dissite *
	
	systemctl reload apache2

	restart
}

###Function will be Responsible for Enable a Certian Virtual Host
function enableVirtualHost {

	#Enter Name of Vurtual Host	
	read -p "Enter the Virtual Host Name : " VIRTUALHOST

	#Check File Found or Not
	checkFileNotFound ${VIRTUALHOST}.conf

	#Enable This Virtual Host
	cd /etc/apache2/sites-available
	
	a2ensite ${VIRTUALHOST}
	
	echo "${VIRTUALHOST} Enabled Successfully"
	
	systemctl reload apache2

	restart
}

###Function will be Responsible for Disable a Certain Virtual Host
function disableVirtualHost {

	local VIRTUALHOST

	#Enter Name of Virtual Host	
	read -p "Enter the Virtual Host Name : " VIRTUALHOST

	#Check File Found or Not
	checkFileNotFound ${VIRTUALHOST}.conf

	#Disable This Virtual Host
	cd /etc/apache2/sites-available
	
	a2dissite ${VIRTUALHOST}
	
	systemctl reload apache2
	
	echo "${VIRTUALHOST} Disabled Successfully"
}

###Function will be Responsible for Add a Certain Virtual Host
function addVirtualHost {
	
	#Read Name of Virtual Host and it's IP Address	
	read -p "Enter Name of Virtual Host : " VIRTUALHOST
	
	read -p "Enter Local IP Address : " IPADDRESS
	
	#Create Virtual Host with Virtual Host Name
	FOLDERNAME=/var/www/html/${VIRTUALHOST}
	
	mkdir /var/www/html/${VIRTUALHOST}
	
	cp mainpage.html /var/www/html/${VIRTUALHOST}/index.html
	  
	
	#Creating Configuration Files
	cp virtualhost.conf /etc/apache2/sites-available/${VIRTUALHOST}.conf
	
	cd /etc/apache2/sites-available/
	
	sed -i "s/example.local/${VIRTUALHOST}/g" ${VIRTUALHOST}.conf
	
	sed -i "s/127.0.0.x/${IPADDRESS}/g" ${VIRTUALHOST}.conf
	
	sed -i "s|example.dir|${FOLDERNAME}|g" ${VIRTUALHOST}.conf
	
	echo "Configuration files created"

	#Enable Virtual Host and restart Apache Server
	cd /etc/apache2/sites-available
	
	a2ensite ${VIRTUALHOST}.conf
	
	service apache2 reload
	
	echo "Restarted apache"
}

###Function will be Responsible for Delete a Certian Virtual Host
function deleteVirtualHost {
	
	#Enter Name of Virtual Host	
	read -p "Enter Name of Virtual Host: " VIRTUALHOST

	#Check File Found or Not
	checkFileNotFound ${VIRTUALHOST}.conf

	#Remove From Sites Available
	rm /etc/apache2/sites-available/${VIRTUALHOST}.conf

	rm /etc/apache2/sites-enabled/${VIRTUALHOST}.conf

	#Remove From Document Root
	rm -rf /var/www/html/${VIRTUALHOST}
	
	echo "${VIRTUALHOST} is Deleted Successfully"

	restart
}

###Function will be Responsible for Enable Authentication of VIRTUALHOST
function enableAuthentication {
	
	#Read Name of Virtual Host and it's IP Address	
	read -p "Enter the Virtual Host Name : " VIRTUALHOST
	
	read -p "Enter Local IP Address : " IPADDRESS

	FOLDERNAME=/var/www/html/${VIRTUALHOST}
	
	#Install Apache2 Utils to enable Authentication
	apt-get update
	
	apt-get install apache2-utils

	touch ${FOLDERNAME}/.htpasswd
	
	read -p "Enter User Name : " USERNAME
	
	#require Password for User
	htpasswd ${FOLDERNAME}/.htpasswd ${USERNAME}

	
	#Creating Configuration Files
	cp virtualhostwithAuth.conf /etc/apache2/sites-available/${VIRTUALHOST}withAuth.conf
	
	sed -i "s/example.local/${VIRTUALHOST}/g" /etc/apache2/sites-available/${VIRTUALHOST}withAuth.conf
	
	sed -i "s/127.0.0.x/${IPADDRESS}/g" /etc/apache2/sites-available/${VIRTUALHOST}withAuth.conf
	
	sed -i "s|example.dir|${FOLDERNAME}|g" /etc/apache2/sites-available/${VIRTUALHOST}withAuth.conf

	cp htaccess ${FOLDERNAME}/.htaccess
	
	cd ${FOLDERNAME}
	
	sed -i "s|example.dir|${FOLDERNAME}|g" .htaccess
	
	echo "Authentication Successfully Created"
	
	service apache2 reload
}

###Function will be Responsible for Disable Authentication of VIRTUALHOST
function disableAuthentication {

	read -p "Enter the site name : " VIRTUALHOST

	FOLDERNAME=/var/www/html/${VIRTUALHOST}

	#Check File Found or Not
	checkFileNotFound ${VIRTUALHOST}.conf

	rm /etc/apache2/sites-available/${VIRTUALHOST}withAuth.conf
	
	rm ${FOLDERNAME}/.htaccess ${FOLDERNAME}/.htpasswd

	echo "Authentication Disabled Successfully"

	systemctl reload apache2
}

###Function will be Responsible for Creating Files in a Certain Virtual Host
function createFiles {

	local COUNTER=1

	local VIRTUALHOST

	local FILE

	local NUM

	read -p "Enter Name of Virtual Host: " VIRTUALHOST

	read -p "Enter Number of Files: " NUM

	#Check for Directory Found or Not
	checkFileNotFound /var/www/html/${VIRTUALHOST}

	while [ ${COUNTER} -le ${NUM} ]

	do
		read -p "Enter Name of File: " FILE

		touch /var/www/html/${VIRTUALHOST}/${FILE}

		((COUNTER++))

	done

	echo "Files Created Successfully"
}

###Function will be Responsible for Creating Directories in a Certain Virtual Host
function createDirectories {
	
	local COUNTER=1

	local VIRTUALHOST

	local DIRECTORY

	local NUM

	read -p "Enter Name of Virtual Host: " VIRTUALHOST
	
	read -p "Enter Number of Directories: " NUM

	#Check for Directory Found or Not
	checkFileNotFound /var/www/html/${VIRTUALHOST}
	
	while [ ${COUNTER} -le ${NUM} ]
	
	do
		read -p "Enter Name of Directory: " DIRECTORY

		mkdir /var/www/html/${VIRTUALHOST}/${DIRECTORY}

		((COUNTER++))
	done

	echo "Directories Created Successfully"
}

###Developed By Islam Shaaban
