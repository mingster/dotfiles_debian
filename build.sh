#!/bin/bash

# ==============================================================================
#
# I use this script to selectively install programs I regularly use.
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
options[1]="System setup"
options[2]="Install R and RStudio"
options[3]="Install useful R packages"
options[4]="Install Visual Studio Code"
options[5]="Install Zotero"
options[6]="Install Zoom"
options[7]="Install Texlive"
options[8]="Install Signal"

# define actions based on options
function ACTIONS {
    if [[ ${choices[0]} ]]; then
        exit 1
    fi
    if [[ ${choices[1]} ]]; then
        source ~/dotfiles/install/system_setup.sh
    fi
    if [[ ${choices[2]} ]]; then
        source ~/dotfiles/install/install_r_rstudio.sh
    fi
    if [[ ${choices[3]} ]]; then
        source ~/dotfiles/install/install_r_packages.sh
    fi
    if [[ ${choices[4]} ]]; then
        source ~/dotfiles/install/install_vscode.sh
    fi
    if [[ ${choices[5]} ]]; then
        source ~/dotfiles/install/install_zotero.sh
    fi
    if [[ ${choices[6]} ]]; then
        source ~/dotfiles/install/install_zoom.sh
    fi
    if [[ ${choices[7]} ]]; then
        source ~/dotfiles/install/install_texlive.sh
    fi
    if [[ ${choices[8]} ]]; then
        source ~/dotfiles/install/install_signal.sh
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
