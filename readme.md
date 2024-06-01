# Dotfiles

## Description

These configuration files are simlinked into the parent directory using [GNU Stow](https://www.gnu.org/software/stow/).

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
