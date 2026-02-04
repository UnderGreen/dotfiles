#!/bin/bash

# Directories to ignore when stowing
IGNORE_DIRS=(".git" ".claude" ".DS_Store")

# Install Homebrew if not installed
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install packages from Brewfile
echo "Installing packages..."
brew bundle --file=~/dotfiles/Brewfile

# Detect OS
if [[ "$(uname)" == "Darwin" ]]; then
    OS_TYPE="macos"
elif grep -qi microsoft /proc/version 2>/dev/null || grep -qi wsl /proc/version 2>/dev/null; then
    OS_TYPE="wsl"
else
    OS_TYPE="linux"
fi
echo "Detected OS: $OS_TYPE"

# Stow dotfiles
echo "Linking dotfiles..."
cd ~/dotfiles

for dir in */; do
    dir_name="${dir%/}"

    # Skip if in ignore list
    skip=false
    for ignore in "${IGNORE_DIRS[@]}"; do
        if [[ "$dir_name" == "$ignore" ]]; then
            skip=true
            break
        fi
    done

    if [[ "$skip" == false ]]; then
        echo "Stowing $dir_name..."
        stow --adopt "$dir_name"
    fi
done

# Symlink OS-specific gitconfig
if [[ -f "$HOME/.gitconfig.$OS_TYPE" ]]; then
    ln -sf "$HOME/.gitconfig.$OS_TYPE" "$HOME/.gitconfig.local"
    echo "Linked .gitconfig.$OS_TYPE to .gitconfig.local"
fi

echo "Done! Restart your terminal."
