# Dotfiles

## Description

These configuration files are simlinked into the parent directory using [GNU Stow](https://www.gnu.org/software/stow/).

## Setup

### Prerequisites

Set zsh as the default terminal

```sh
chsh -s $(which zsh)
```

Install Nix

```sh
curl -L https://nixos.org/nix/install | sh
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

Build the Nix Flake

```sh
# Personal Flake
darwin-rebuild switch --flake ~/dotfiles/nix/darwin/personal/flake.nix#personal

# Tesla Flake
darwin-rebuild switch --flake ~/dotfiles/nix/darwin/tesla/flake.nix#tesla
```

Then close and restart your terminal. The setup process will run the first time you open a new terminal after running the setup script.
