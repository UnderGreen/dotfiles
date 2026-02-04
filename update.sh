#!/bin/bash
echo "Updating Homebrew..."
brew update

echo "Upgrading all packages..."
brew upgrade

echo "Upgrading casks (including auto-update apps)..."
brew upgrade --greedy

echo "Ensuring Brewfile packages are installed..."
brew bundle --file=~/dotfiles/Brewfile

echo "Cleaning up..."
brew cleanup
