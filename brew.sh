#!/usr/bin/env bash
set -euo pipefail

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
    echo "Installing homebrew..."
      ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
# Update homebrew recipes
brew update

# Core utils / GNU
brew install coreutils
brew install findutils
brew install bash
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

# development
brew install git
brew install node
brew install python3
brew install azure-cli
brew install vsts-cli
brew install yarn

# New / experimental
brew install tig

# MSSQL Tools
brew tap microsoft/mssql-release https://github.com/Microsoft/homebrew-mssql-release
brew update
brew install mssql-tools

# Casks
brew tap caskroom/cask
brew tap caskroom/fonts 
brew tap homebrew/cask-versions  # For Java 8

# fonts
brew cask install font-hack-nerd-font-mono
brew cask install font-hack-nerd-font
brew cask install font-firacode-nerd-font-mono
brew cask install font-firacode-nerd-font
brew cask install font-inconsolata-nerd-font-mono
brew cask install font-inconsolata-nerd-font
brew cask install font-meslo-nerd-font-mono
brew cask install font-meslo-nerd-font
brew cask install font-sourcecodepro-nerd-font-mono
brew cask install font-sourcecodepro-nerd-font

# dev-related programs
brew cask install adoptopenjdk
brew cask install atom
brew cask install docker
brew cask install gitkraken
brew cask install dotnet-sdk
brew cask install diffmerge
brew cask install dropbox
brew cask install firefox
brew cask install firefox-developer-edition
brew cask install google-chrome
brew cask install iterm2
#brew cask install java
brew cask install jetbrains-toolbox
brew cask install postman
brew cask install sublime-merge
brew cask install sourcetree
brew cask install onedrive
brew cask install visual-studio-code

# Productivity
brew cask install 1password
brew cask install appcleaner
brew cask install bitwarden
brew cask install caffeine
brew cask install coconutbattery
brew cask install discord
brew cask install macdown
brew cask install microsoft-office
brew cask install slack
brew cask install skype
brew cask install spotify
brew cask install whatsapp
brew cask install vlc

# Games
brew cask install dosbox
brew cask install steam
brew cask install gog-galaxy

# New / experimental
#brew cask install background-music
#brew cask install minikube

