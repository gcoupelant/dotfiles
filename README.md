# Dotfiles

## Usage

### Install requirements

These commands will install the required/important packages.
```bash
# Debian/Ubuntu
sudo apt update
sudo apt -y install build-essential procps curl file git podman zsh

# RHEL/Fedora
sudo dnf update
sudo dnf -y groupinstall 'Development Tools'
sudo dnf -y install procps-ng curl file git podman zsh
```

This script will install the latest Homebrew (see: https://docs.brew.sh/Installation).
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Clone this repository

```bash
mkdir -p ~/src/github.com/gcoupelant
cd  ~/src/github.com/gcoupelant
git clone git@github.com:gcoupelant/dotfiles.git
cd dotfiles
```

### Install brew apps

```bash
xargs brew install < brew_apps.txt
```

### Stow dotfiles

```bash
stow -t ~ -vv bash
stow -t ~ -vv git
stow -t ~ -vv zsh
stow -t ~ -vv ssh

# For WSL only
stow -t ~ -vv wsl
```

### Extra

#### WSL
If using WSL, check the wiki page about the potential extra steps to do: https://github.com/gcoupelant/dotfiles/wiki/WSL

#### SSH Config
Make sure the ssh config directory exists (to prevent subsequent stow from creating a symlink instead).
```bash
mkdir -p ~/.ssh/config.d
```
