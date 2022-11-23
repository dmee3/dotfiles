#!/usr/bin/env bash

set -eou pipefail

setup () {
  readonly DIR="$(dirname "$0")"

  . "${DIR}/shell/functions.sh"
  . "${DIR}/os/all.sh"

  # Install brew
  if test ! $(which brew); then
    echo "Installing Homebrew."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo
  fi

  # Determine which OS we are in and follow the corresponding script
  case $OSTYPE in
    darwin*) . "${DIR}/os/macos.sh" ;;
      msys*) . "${DIR}/os/windows.sh" ;;
          *) exit ;;
  esac
}

setup
