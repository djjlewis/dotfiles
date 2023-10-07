#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

sudo apt-get update -q
sudo apt-get upgrade -yq

# Install npm if not already installed
if ! command -v npm &> /dev/null; then
    sudo apt-get install -yq npm
fi

# diff-so-fancy
sudo npm install -g diff-so-fancy

# neovim
if ! command -v nvim &> /dev/null; then
    sudo apt-get install -yq neovim
fi

# stow
if ! command -v stow &> /dev/null; then
    sudo apt-get install -yq stow
fi

# starship
sh -c "$(curl -sS https://starship.rs/install.sh)" -- --yes

mv ~/.bashrc ~/.bashrc.bak
mv ~/.zshrc ~/.zshrc.bak
mv ~/.gitconfig ~/.gitconfig.bak

stow bash git zsh

echo "Devcontainer dotfile setup complete."