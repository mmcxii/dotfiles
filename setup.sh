#!/usr/bin/env bash

OS=$(uname -s)

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if all required packages are already installed
if command_exists nix && command_exists home-manager && [ -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "All packages are already installed."
    exit 0
fi

# Install Nix if not already installed
if ! command_exists nix; then
    # https://nixos.org/download/
    if [ "$OS" = "Darwin" ]; then
        sh <(curl -L https://nixos.org/nix/install)
    else
        sh <(curl -L https://nixos.org/nix/install) --daemon
    fi
fi

# Install Home Manager if not already installed
if ! command_exists home-manager; then
    # https://nix-community.github.io/home-manager/index.xhtml#sec-flakes-standalone
    nix --extra-experimental-features "nix-command flakes" run nixpkgs#home-manager
fi

# Ensure TPM is installed
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

# More robust tmux plugin installation
if [ -d "$HOME/.tmux/plugins/tpm" ]; then
    # Check if tmux is running
    if command_exists tmux; then
        # Try to source TPM install script
        # This works across different systems
        "$HOME/.tmux/plugins/tpm/scripts/install_plugins.sh"
    fi
fi
