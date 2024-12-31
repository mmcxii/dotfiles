# Dotfiles

## Description

This repository contains dotfiles and packages configured with Nix and Home Manager.

## Setup

### Prerequisites

Set zsh as the default terminal

```sh
chsh -s $(which zsh)
```

### Installation

Clone the repository into the home directory.

```sh
cd $HOME

git clone git@github.com:mmcxii/dotfiles.git
```

Run the setup script

```sh
cd ./dotfiles
sh ./setup.sh
```

Then close and restart your terminal. The setup process will run the first time you open a new terminal after running the setup script.

Build the Nix Configurations

(Note: The initial build may require the use of the `--experimental-extra-features "nix-command flakes"` flag.)

```sh
# Personal
darwin-rebuild switch --flake ~/dotfiles/#personal
home-manager switch --flake ~/dotfiles/#personal

# Business
darwin-rebuild switch --flake ~/dotfiles/#business
home-manager switch --flake ~/dotfiles/#personal
```

