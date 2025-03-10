# Dotfiles

## Install requirements

These commands will install the required/important packages.

### Debian/Ubuntu
```bash
sudo apt update
sudo apt -y install build-essential procps curl file git podman zsh

# If using WSL
[[ -n $WSLENV ]] && sudo apt -y install wslu
```

### RHEL/Fedora
```bash
sudo dnf update
sudo dnf -y groupinstall 'Development Tools'
sudo dnf -y install procps-ng curl file git podman zsh

# If using WSL
[[ -n $WSLENV ]] && sudo dnf -y install wslu
```

This script will install the latest Homebrew (see: https://docs.brew.sh/Installation).
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Clone this repository

```bash
mkdir -p ~/src/github.com/gcoupelant
cd  ~/src/github.com/gcoupelant
git clone git@github.com:gcoupelant/dotfiles.git
cd dotfiles
```

## Install brew apps

```bash
xargs brew install < brew_apps.txt
```

## Install ZSH plugins

```bash
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM}/plugins/zsh-completions
git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM}/plugins/fzf-tab
```

## Stow dotfiles

```bash
stow -t ~ -vv bash
stow -t ~ -vv git
stow -t ~ -vv zsh
stow -t ~ -vv ssh

# If using WSL
[[ -n $WSLENV ]] && stow -t ~ -vv wsl
```

## Extra

### WSL
If using WSL, check the wiki page about the potential extra steps to do: https://github.com/gcoupelant/dotfiles/wiki/WSL

### SSH Config
Make sure the ssh config directory exists (to prevent subsequent stow from creating a symlink instead).
```bash
mkdir -p ~/.ssh/config.d
```
