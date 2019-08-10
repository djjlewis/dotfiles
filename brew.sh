#!/usr/bin/env bash

# Abort on error
set -e

echo "Checking if Homebrew is already installed..."; 

# Checks if Homebrew is installed
# Credit: https://gist.github.com/codeinthehole/26b37efa67041e1307db
if test ! $(which brew); then
  echo "Installing Homebrew...";
  yes | /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" &> /dev/null
else
  echo "Homebrew is already installed...";
fi

echo "Updating and upgrading Homebrew..."; echo;

yes | brew update &> /dev/null
yes | brew upgrade &> /dev/null

# Core utils / GNU
brew install coreutils
brew install findutils
brew install gawk
brew install grep
brew install gnu-sed
brew install gnu-tar
brew install gnupg
brew install make
brew install wget

# Other utils
brew install ack
brew install htop
brew install tmux
brew install tree
brew install unrar
brew install vim
brew install macvim

# development
brew install git
brew install node
brew install python3
brew install azure-cli
brew install dotnet-sdk
brew install vsts-cli
brew install yarn

# New / experimental
brew install tig

# MSSQL Tools
brew tap microsoft/mssql-release https://github.com/Microsoft/homebrew-mssql-release
HOMEBREW_NO_ENV_FILTERING=1 ACCEPT_EULA=y brew install mssql-tools

# Casks
brew tap caskroom/cask
brew tap caskroom/fonts 

function installcask() {
    brew cask install "${@}" 2> /dev/null
}

# fonts
installcask font-hack-nerd-font-mono
installcask font-hack-nerd-font
installcask font-firacode-nerd-font-mono
installcask font-firacode-nerd-font
installcask font-inconsolate-nerd-font-mono
installcask font-inconsolate-nerd-font
installcask font-meslo-nerd-font-mono
installcask font-meslo-nerd-font
installcask font-sourcecodepro-nerd-font-mono
installcask font-sourcecodepro-nerd-font

# dev-related programs
installcask adoptopenjdk
installcask atom
installcask docker
installcask gitkraken
installcask dotnet-sdk
installcask diffmerge
installcask dropbox
installcask firefox
installcask firefox-developer-edition
installcask google-chrome
installcask iterm2
#installcask java
installcask jetbrains-toolbox
installcask postman
installcask sublime-merge
installcask sourcetree
installcask onedrive
installcask visual-studio-code

# Productivity
installcask 1password
installcask appcleaner
installcask bitwarden
installcask bitwarden-cli
installcask caffeine
installcask coconutbattery
installcask discord
installcask macdown
installcask microsoft-office
installcask slack
installcask skype
installcask spotify
installcask whatsapp
installcask vlc

install cask steam

# New / experimental
#installcask background-music
#installcask minikube

