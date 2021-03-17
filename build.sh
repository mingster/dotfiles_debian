#!/bin/bash

# ==============================================================================
#
# This script makes it possible to select what to install from my dotfiles
#
# It's based on work by Nathan Davieau and MestreLion from
# https://serverfault.com/a/777849
#
# ==============================================================================

# define colors
GREEN='\033[1;32m'
RED='\033[0;31m'
NC='\033[0m'

# define menu options
options[0]="${RED}Abort${NC}"
options[1]="Upgrade to latest Linux kernel"
options[2]="Install everyting required by dotfiles"
options[3]="Install R and Radian"

# define actions based on options
function ACTIONS {
    if [[ ${choices[0]} ]]; then
        exit 1
    fi
    if [[ ${choices[1]} ]]; then
        source ~/dotfiles/build/01_kernel_upgrade.sh
    fi
    if [[ ${choices[2]} ]]; then
        source ~/dotfiles/build/02_system_setup.sh
    fi
    if [[ ${choices[3]} ]]; then
        source ~/dotfiles/build/03_install_r.sh
    fi
}

ERROR=" "

clear

# menu function
function MENU {
    echo ""
    echo "---------------------------------------------------------------------"
    for NUM in ${!options[@]}; do
        echo -e $(( NUM+1 ))" "[""${GREEN4}${choices[NUM]:- }"${NC}"]" ${options[NUM]}"
    done
    echo "---------------------------------------------------------------------"
    echo "$ERROR"
}

# menu loop
while MENU && read -e -p "Select by pressing the corresponding number (press again to deselect), then ENTER when done: " -n1 SELECTION && [[ -n "$SELECTION" ]]; do
    clear
    if [[ "$SELECTION" == *[[:digit:]]* && $SELECTION -ge 1 && $SELECTION -le ${#options[@]} ]]; then
        (( SELECTION-- ))
        if [[ "${choices[SELECTION]}" == "+" ]]; then
            choices[SELECTION]=""
        else
            choices[SELECTION]="+"
        fi
            ERROR=" "
    else
        ERROR="Invalid option: $SELECTION"
    fi
done

ACTIONS
