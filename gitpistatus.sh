#!/bin/bash
# A menu driven shell script sample template
## ----------------------------------
# Step #1: Define variables
# ----------------------------------

VERSION="0.5"


RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color
STD='\033[0;0;39m'

GIT_ROOT_PATH=''
CONFIG_FILE="config.cfg"




pause(){
  read -p "Press [Enter] key to continue..." fackEnterKey
}

exit_to_main_menu(){
echo ""
echo "Press [Enter] to exit main menu..."
read -s -n 1 key
if [[ $key = "" ]]; then
    main_menu
else
    echo ""
fi
}

exit_to_terminal(){
	clear
	exit 0
}


root_not_set(){
	clear
	echo "Git root path not found"
	echo "To list avaiable git repos, please set git root path first"
        exit_to_main_menu
}


list_avaiable_git_repos(){
if [ ! -f $CONFIG_FILE ]; then
   root_not_set
else
	# if file exist
	read -d $'\x04' pathvalue < "$CONFIG_FILE"
   if [[ $pathvalue = "" ]]; then
		root_not_set
   else
	GIT_ROOT_PATH=$pathvalue;
	clear
	echo -e "${GREEN}"
	echo -e "#########################################################"
	echo -e "   ____ ___ _____   ____                           "
	echo -e "  / ___|_ _|_   _| |  _ \ ___  ___ _ __   ___  ___ "
	echo -e " | |  _ | |  | |   | |_) / _ \/ __| '_ \ / _ \/ __|"
	echo -e " | |_| || |  | |   |  _ <  __/\__ \ |_) | (_) \__ \\"
	echo -e "  \____|___| |_|   |_| \_\___||___/ .__/ \___/|___/"
	echo -e "                                  |_|               "
	echo -e ""
	echo -e ""
	echo -e "for root path: "$GIT_ROOT_PATH
	echo -e "_____________________________________________"
	echo -e "${NC}"
	find $GIT_ROOT_PATH -type d -name '*.git'
        exit_to_main_menu
   fi
fi


}

create_a_new_git_repo(){
	clear
#	echo "Avaiable folders:"
#	echo ""
#	find $GIT_ROOT_PATH  -maxdepth 1 -type d -not -name "*.git"
#	find $GIT_ROOT_PATH -type d -name '*.git'
#	echo ""
#	exit_to_main_menu

}




show_hardware_info(){
while true
do
	clear
	echo -e "${GREEN}"
	echo -e "#########################################################"
	echo -e "  ____            _                   _        __        "
	echo -e " / ___| _   _ ___| |_ ___ _ __ ___   (_)_ __  / _| ___   "
	echo -e " \___ \| | | / __| __/ _ \ '_ ' _ \  | | '_ \| |_ / _ \  "
	echo -e "  ___) | |_| \__ \ ||  __/ | | | | | | | | | |  _| (_) | "
	echo -e " |____/ \__, |___/\__\___|_| |_| |_| |_|_| |_|_|  \___/  "
	echo -e "        |___/                                            "
	echo -e "${NC}"
	echo -e "${YELLOW}Memory status${NC}"
	echo "----------------------------------"
	free -h
	echo ""
	echo -e "${YELLOW}File system status${NC}"
	echo "----------------------------------"
	df -h
	exit_to_main_menu
done
}

set_git_root_path(){
	clear
	echo "SET GIT ROOT FOLDER"
	echo ""
	echo "Set the root path for your git repo."
	echo "The git root folder is the root of your projects. It can contain subfolders, and within them contains the .git folders."
	echo "Use absolute path, like: /home/myusername/mygitfolder/"
	echo ""

if [ ! -f $CONFIG_FILE ]; then
   	echo "Current git root folder: Not set"
else
	# if file exist
	read -d $'\x04' pathvalue < "$CONFIG_FILE"
   if [[ $pathvalue = "" ]]; then
		echo "Current git root folder: Not set"
   else
	GIT_ROOT_PATH=$pathvalue;
	echo "Current git root folder: "$GIT_ROOT_FOLDER
   fi
fi


	read -p "Enter a valid path: " folder
	if [[ $folder = "" ]]; then
   	  set_git_root_path
	else
		echo ""
		echo "Your new Git root folder: "$folder
		read -p "Save this configuration? (Y/n)" choose

		if [[ $choose = "Y" ]]; then
		   echo $folder > $CONFIG_FILE
		main_menu
		else
		   set_git_root_path
		fi

	fi
}




show_git_path_status(){

if [ ! -f $CONFIG_FILE ]; then
   	echo -e "   \033[31m!!! Git root path is not set !!!\e[0m"
	echo -e "   \033[31m Please set the git root firs !\e[0m"
else
	# if file exist
	read -d $'\x04' pathvalue < "$CONFIG_FILE"
   if [[ $pathvalue = "" ]]; then
		echo -e "   \033[31m!!! Git root path is not set !!!\e[0m"
		echo -e "   \033[31m Please set the git root firs !\e[0m"
   else
    	echo " Git root path: "$pathvalue
	GIT_ROOT_PATH=$pathvalue;
   fi
fi

}
# function to display menus
show_menus() {
USERNAME=$(id -un)
OS=$(lsb_release -d -s)
THISHOST=$(hostname --long)

DATE=`date +%Y-%m-%d%t%H:%M:%S%t%Z`
LOCAL_IP=`ifconfig ${NET_IF} | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'`
EXT_IP=$(nc 4.ifcfg.me 23 | grep IPv4 | cut -d' ' -f4)
	clear
	echo -e "${YELLOW}#######################################################"
	echo -e "     ____ ___ _____   ____                           "
	echo -e "    / ___|_ _|_   _| / ___|  ___ _ ____   _____ _ __ "
	echo -e "   | |  _ | |  | |   \___ \ / _ \ '__\ \ / / _ \ '__|"
	echo -e "   | |_| || |  | |    ___) |  __/ |   \ V /  __/ |   "
	echo -e "    \____|___| |_|   |____/ \___|_|    \_/ \___|_|   "
	echo -e "                                                     "
	echo -e "      Version: "$VERSION"      created by: theophrast${NC}"
	echo ""
	echo -e "${GREEN}"
	echo -e "   Hostname: "$THISHOST
	echo -e "   Operating System: "$OS
	echo -e "   User: " $USERNAME
	echo -e "   Local  IP: "$LOCAL_IP
	echo -e "   Public IP: "$EXT_IP
	echo -e "   System time: "$DATE
	echo -e "${NC}"
	echo ""
	show_git_path_status
	echo ""
	echo -e "  ${GREEN}___________________________________________________${NC}"
	echo ""
	echo "   1. Show server status (disk usage, memory etc.)"
	echo ""
	echo "   2. Set GIT root folder path"
	echo "   3. List avaiable git repos"
	echo "   4. Create and init new git repo"
	echo "   5. Exit"
	echo ""
	echo -e "  ${GREEN}___________________________________________________${NC}"
	echo ""
}


# read input from the keyboard and take a action
# invoke the one() when the user select 1 from the menu option.
# invoke the two() when the user select 2 from the menu option.
# Exit when user the user select 3 form the menu option.
read_options(){
	local choice
	read -p "Enter choice [ 1 - 5] " choice
	case $choice in
		1) show_hardware_info ;;
		2) set_git_root_path ;;
		3) list_avaiable_git_repos ;;
		4) create_a_new_git_repo ;;
		5) exit_to_terminal;;
		*) echo -e "${RED}Error...${STD}" && sleep 2
	esac
}

# ----------------------------------------------
# Step #3: Trap CTRL+C, CTRL+Z and quit singles
# ----------------------------------------------
#trap '' SIGINT SIGQUIT SIGTSTP

# -----------------------------------
# Step #4: Main logic - infinite loop
# ------------------------------------

main_menu(){
while true
do

	show_menus
	read_options
done
}

# this function is called when Ctrl-C is sent
function trap_ctrlc ()
{
  exit_to_terminal
}

# initialise trap to call trap_ctrlc function
# when signal 2 (SIGINT) is received
trap "trap_ctrlc" 2




main_menu
