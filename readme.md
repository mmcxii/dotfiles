# Dotfiles

## Description

These configuration files are simlinked into the parent directory using [GNU Stow](https://www.gnu.org/software/stow/).

## Setup

### Prerequisites

Install dependencies.

```sh
brew install stow
brew install fzf
brew install zoxide
```

## Installation

Clone the repository into the home directory.

```sh
cd $HOME

git clone git@github.com:mmcxii/dotfiles.git
```

Then enter the dotfiles folder and link it to its parent folder using stow.

```sh
cd ./dotfiles

stow .
```
