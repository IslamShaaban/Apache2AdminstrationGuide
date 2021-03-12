###This Module to Check the Input of User

###Check for Port Number
function checkPortNumber {

	ISNUMBER=${1}
	
	if ! [[ "${ISNUMBER}" =~ ^[0-9]+$ ]]
 
    then
        echo "Sorry Numbers Only"

		exit 1
	fi
}

###Check for Package Installed
function checkPackageInstalled {

	PACKAGENAME=${1}
	
	ISINSTALLED=$( dpkg --get-selections | grep ${PACKAGENAME} | wc -l )
		
	if [ ${ISINSTALLED} -ne 0 ] 
		
		then
			echo "${PACKAGENAME} already Installed" 

		else
			echo "${PACKAGENAME} not Installed"
	fi
}

###Check for File Found
function checkFileFound {
	
	FILENAME=${1}

	cd /etc/apache2/sites-available

	if [[ -f "${FILENAME}" ]]
	
	then
		echo "****************File or Directory is Found********************"

		exit 1
	else
		echo "****************File or Directory Not Found*******************"
	fi
}

###Check for File Not Found
function checkFileNotFound {
	
	FILENAME=${1}

	cd /etc/apache2/sites-available

	if [[ -f "${FILENAME}" ]]
	
	then
		echo "****************File or Directory is Found********************"
	else
		echo "****************File or Directory Not Found*******************"

		displayVirtualHostMenu

		runVirtualHostMenu
	fi
}

###Developed By Islam Shaaban