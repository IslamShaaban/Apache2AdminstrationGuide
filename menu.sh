###Welcome to Apache2 Adminstration Guide

###This Module will be Responsible for show User Interface

###Function to Display Main Menu
function displayMainMenu {
	
	echo "*******************************************************************************************************"

	echo "Welcome to Apache2 Adminstration Guide"
	
	echo "This is a Simple Guide for Install, Configure and Uninstall Apache2 with Linux Debian Operating System"

	echo -e "CopyRight \u00a9 2021 Islam Shaaban - ITI41OS"
		
	echo "Apache2 Main Menu"
	
	echo "*******************************************************************************************************"
	
	echo "1) Install Apache2 Service"
	
	echo "2) Uninstall Apache2 Service"
	
	echo "3) Run Apache2 Service"
	
	echo "4) Stop Apache2 Service"
	
	echo "5) Restart Apache2 Service"
	
	echo "6) Check Apache2 Status"

	echo "7) Create File"
	
	echo "8) Create Directory"	
	
	echo "9) Change Port with Local Host"
	
	echo "10) Virtual Host Configuration"
	
	echo "11) Exit"
}

###Function to Display Virtual Host Menu  
function displayVirtualHostMenu {
	
	echo "Virtual Host Menu"
	
	echo "******************************************************"
	 
	echo "1) Add Virtual Host"
	
	echo "2) Delete Virtual Host"
	
	echo "3) List All Virtual Hosts"
	
	echo "4) Disable Virtual Host"
	
	echo "5) Enable Virtual Host"
	
	echo "6) Enable All Virtual Hosts"
	
	echo "7) Disable All Virtual Hosts"

	echo "8) Enable Authentication for Virtual Host"
	
	echo "9) Disable Authentication for Virtual Host"

	echo "10) Return Main Menu"	
}

###Function to Run Main Menu
function runMainMenu {

	#User Choice
	local CHOOSE

	local FLAG=1
	
	while [ ${FLAG} -eq 1 ]
	
	do
	
	echo "Enter Your Choice: "

	read CHOOSE
	
	case ${CHOOSE} in
	
			"1")
				#install Apache2 Service
				install
			;;
			
			"2")
				#uninstall Apache2 Service
				uninstall
			;;
			
			"3")
				#run Apache2 Service
				start
			;;
			
			"4")
				#stop Apache2 Service
				stop
			;;
			
			"5")
				#restart Apache2 Service
				restart			
			;;
			
			"6")
				#Check Apache2 Service Status
				checkStatus
			;;
			
			"7")
				#Create Files in Your Virtual Host
				createFiles
			;;
			
			"8")
				#Create Directories in Your Virtual Host
				createDirectories
			;;
			
			"9")
				#Configure Port with Localhost
				portConfig
			;;
			
			"10")
				#Virtual Host Configuration
				displayVirtualHostMenu
				
				runVirtualHostMenu

				FLAG=0
			;;

			"11")
				#Exit
				echo "Thank You for Using our Program"
				FLAG=0
			;;

			*)
				echo "Invalid Choice, Please try Again" 
	esac
	
	if [ ${FLAG} -eq 1 ]
	
	then
		displayMainMenu
	fi
	
	done
	
	exit 0
}

###Function to Run Virtual Host Menu
function runVirtualHostMenu {
	
	#User Choice
	local CHOOSE
	
	local FLAG=1
	
	while [ ${FLAG} -eq 1 ]
	
	do

	echo "Enter your choice"

	read CHOOSE
	
	case ${CHOOSE} in
	
			"1")
				addVirtualHost
			;;
			
			"2")
				deleteVirtualHost
			;;
			
			"3")
				showAllVirtualHosts
			;;
			
			"4")
				disableVirtualHost
			;;
			
			"5")
				enableVirtualHost
			;;
			
			"6")
				enableAllVirtualHosts
			;;
			
			"7")
				disableAllVirtualHosts
			;;

			"8")
				enableAuthentication
			;;

			"9")
				disableAuthentication
			;;

			"10")
				FLAG=0;
			;;

			*)
				echo "Invalid Choice, Please try Again"
	esac
	
	if [ ${FLAG} -eq 1 ]
	
	then
		displayVirtualHostMenu
	else
		displayMainMenu
		runMainMenu
	fi

	done
}

###Developed By Islam Shaaban
