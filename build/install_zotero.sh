#!/bin/sh

#####################################################################################################
#
# This script installs the latest version of Zotero as well as a Java runtime environment (JRE)
# https://www.zotero.org/
# https://openjdk.java.net/
# 
#####################################################################################################

set -e
trap 'catch $? $LINENO' EXIT

catch() {
  if [ "$1" != "0" ]; then
    echo -e "\033[1;31mInstallation failed!\033[0m"
    echo -e "\033[1;31mError $1 occurred on $2\033[0m"
  fi
}

simple() {
  if ! command -v zotero &> /dev/null; then
      wget -qO- https://apt.retorque.re/file/zotero-apt/install.sh | sudo bash
      sudo apt update
      sudo apt install zotero
  else
      echo "Zotero is already installed"
  fi
}

simple

echo ""
echo -e "\033[1;32m"--------------------------------------------------------------------------------------------------"\033[0m"
echo -e "\033[1;32mZotero installation OK\033[0m"
echo -e "\033[1;32m"--------------------------------------------------------------------------------------------------"\033[0m"
echo ""
