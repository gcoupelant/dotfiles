# Add `~/dev/bin` to the `$PATH`
export PATH="$HOME/dev/bin:$PATH"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the OhMyZSH theme to load.
# Look in ~/.oh-my-zsh/custom/themes/ and ~/.oh-my-zsh/themes/
ZSH_THEME="honukai"

# Pacakges managers
export BREW_PREFIX=/usr/local
export PORT_PREFIX=/opt/local

# Use the GNU tools by default
if [ -d "$BREW_PREFIX/bin" ]; then
  export PATH=$BREW_PREFIX/bin:$BREW_PREFIX/sbin:$PATH
fi
if [ -d "$BREW_PREFIX/opt/coreutils/libexec" ]; then
  export PATH=$BREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH
  export MANPATH=$BREW_PREFIX/opt/coreutils/libexec/gnuman:$MANPATH
fi
if [ -d "$BREW_PREFIX/opt/grep/libexec" ]; then
  export PATH=$BREW_PREFIX/opt/grep/libexec/gnubin:$PATH
  export MANPATH=$BREW_PREFIX/opt/grep/libexec/gnuman:$MANPATH
fi
if [ -d "$PORT_PREFIX/libexec" ]; then
  export PATH=$PORT_PREFIX/bin:$PORT_PREFIX/sbin:$PATH
  export PATH=$PORT_PREFIX/libexec/gnubin:$PATH
fi

# Load the shell dotfiles, and then some:
# * ~/.mix-path can be used to extend `$PATH`.
# * ~/.mix-extra can be used for other settings you don’t want to commit to your repo.
for file in ~/.mix-{path,exports,aliases,extra}; do
	[ -r "$file" ] && source "$file"
done
unset file

# --- ZSH CONFIG -----------------------
# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Print exit code if > 0
setopt PRINT_EXIT_VALUE

# --- PLUGINS ----------------------------------
# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# plugins=(git brew bundler capistrano cloudapp composer gem laravel npm rvm bower sublime)
# plugins=(git zsh-syntax-highlighting vi-mode)
# plugins=(git npm docker docker-compose)
plugins=(git docker)

source $ZSH/oh-my-zsh.sh

. ~/.bash_aliases
. ~/.bash_env_var
. ~/.bash_secrets

export PATH=/usr/local/bin:$PATH

export GOPATH=$HOME/dev
export GOBIN=$HOME/dev/bin
export GO111MODULE=on
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# The next line updates PATH for the Google Cloud SDK.
if [ -f "${HOME}/google-cloud-sdk/path.zsh.inc" ]; then source "${HOME}/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "${HOME}/google-cloud-sdk/completion.zsh.inc" ]; then source "${HOME}/google-cloud-sdk/completion.zsh.inc"; fi

export KUBE_PS1_PREFIX="NOT_SET"

# kubectl
# Lazy loading of kubectl completion
function kubectl() {
    if ! type __start_kubectl >/dev/null 2>&1; then
        source <(command kubectl completion zsh)

        source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"
        export KUBE_PS1_PREFIX="\n🐳 "
        export KUBE_PS1_SUFFIX=""
        export KUBE_PS1_DIVIDER=" on "
        export KUBE_PS1_SYMBOL_ENABLE=false
        export KUBE_PS1_CTX_COLOR=blue
        export KUBE_PS1_NS_COLOR=red
        export PROMPT='$(kube_ps1 | perl -pe "s/gke_(\S+)_(\S+)_(\S+) /[GKE] \1 \/ \3 in %{%F{cyan}%}\2%{%f%} /" | perl -pe "s/arn:aws:eks:(\S+):(\S+):cluster\/(\S+) /[EKS] \3 in %{%F{cyan}%}\1%{%f%} /")'$PROMPT
    fi

    command kubectl "$@"
}

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Disable the default virtualenv prompt change and replace with custom one
export VIRTUAL_ENV_DISABLE_PROMPT=1
export PROMPT='$(py_info)'$PROMPT

# ZPlug
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

# ZPlug packages
zplug "changyuheng/fz", defer:1
zplug "rupa/z", use:z.sh

# Install packages that have not been installed yet
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    else
        echo
    fi
fi

# FZ config
FZ_CMD=f
FZ_SUBDIR_CMD=ff

# ZPlug load
zplug load

[[ -s "/Users/gcoupelant/.gvm/scripts/gvm" ]] && source "/Users/gcoupelant/.gvm/scripts/gvm"
