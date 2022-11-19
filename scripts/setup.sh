#!/usr/bin/env bash

BASE=$(basename "$0")

info() {
  echo "${GREEN}$BASE: $1 ${NOCOLOR}"
}

abort() {
  echo "${RED}$BASE: ERROR: $1 ${NOCOLOR}"
  cleanup
  exit 1
}

echo "Installing tfenv..."
brew install tfenv
[ $? -ne 0 ] && abort "Failed to install tfenv!";

echo "Installing terraform..."
tfenv install 0.12.26
[ $? -ne 0 ] && abort "Failed to install terraform!";

echo "Switching terraform..."
tfenv use 0.12.26
[ $? -ne 0 ] && abort "Failed to switch terraform version!";

echo "Done."
