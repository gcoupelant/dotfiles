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

## Oh My Zsh
This script will install the latest Oh My Zsh (see: https://ohmyz.sh/#install).
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## Brew
This script will install the latest Homebrew (see: https://docs.brew.sh/Installation).
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

After this step, please reload your terminal to use `zsh`.

## Clone this repository

```bash
mkdir -p ~/src/github.com/gcoupelant
cd  ~/src/github.com/gcoupelant
git clone git@github.com:gcoupelant/dotfiles.git
cd dotfiles
```

## Install brew apps

First, run the following command to have brew temporarily available (the `.zshrc` file we'll stow later will add `brew` to the PATH permanently):
```bash
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
```

Then install all the brew apps:
```bash
./brew.sh

# If using MacOS
[[ "$(uname)" == "Darwin" ]] && ./brew-macos.sh
```

## Stow dotfiles

First, delete the `.zshrc` file that was created during `zsh`'s installation and make sure the ssh config directory exists (to prevent subsequent stow from creating a symlink instead):
```bash
rm ~/.zshrc
mkdir -p ~/.ssh/config.d
```

Then apply the stow.
```bash
stow -t ~ -vv bash
stow -t ~ -vv git
stow -t ~ -vv zsh
stow -t ~ -vv ssh

# If using WSL
[[ -n $WSLENV ]] && stow -t ~ -vv wsl
```

Finally, reload `zsh` by running:
```bash
source ~/.zshrc
```

You will be prompted to install ZPlug packages, simply reply `y` when asked.

You can now install the following ZSH plugins:
```bash
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM}/plugins/zsh-completions
git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM}/plugins/fzf-tab
```

## Extra

### Locales
If you get warnings about locales, run the following command:
```bash
sudo locale-gen en_US en_US.UTF-8
```

### WSL
If using WSL, check the wiki page about the potential extra steps to do: https://github.com/gcoupelant/dotfiles/wiki/WSL

#### Host's SSH client (for 1Password SSH Agent)

To use the [1Password SSH Agent with WSL](https://developer.1password.com/docs/ssh/integrations/wsl/), you need to use the Windows' host `ssh.exe` program instead of Linux's native `ssh`. This can be done by running this stow:

```bash
stow -t ~ -vv wsl-ssh
```

This will configure `git` to use `ssh.exe` (if using this repository's [`.gitconfig`](git/.gitconfig#L15) file) and create this alias: `ssh="ssh.exe"`.

> This will prevent any keys present in `~/.ssh` to be used.
