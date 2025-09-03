# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="ys-custom"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$HOME/.zsh_custom

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(fzf fzf-tab git kubectl)

# Add zsh-completions to fpath
if [[ -d "${ZSH_CUSTOM}/plugins/zsh-completions/src" ]]; then
    fpath+=${ZSH_CUSTOM}/plugins/zsh-completions/src
fi

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

[[ -f ~/.bash_aliases ]] && source ~/.bash_aliases
[[ -f ~/.bash_env_var ]] && source ~/.bash_env_var
[[ -f ~/.bash_secrets ]] && source ~/.bash_secrets

# Pipenv
export PIPENV_VENV_IN_PROJECT=1

# pyenv
if [[ -d "$HOME/.pyenv" ]]; then
    export PYENV_ROOT="$HOME/.pyenv"
    [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init - zsh)"
    eval "$(pyenv virtualenv-init -)"
fi

# nvm
if [[ -d "$HOME/.nvm" ]]; then
    export NVM_DIR="$HOME/.nvm"

    # Function to load nvm
    _load_nvm() {
        if [[ -s "$NVM_DIR/nvm.sh" ]]; then
            \. "$NVM_DIR/nvm.sh"
        elif [[ -s "$(brew --prefix)/opt/nvm/nvm.sh" ]]; then
            \. "$(brew --prefix)/opt/nvm/nvm.sh"
        fi

        if [[ -s "$NVM_DIR/bash_completion" ]]; then
            \. "$NVM_DIR/bash_completion"
        elif [[ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ]]; then
            \. "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm"
        fi
    }

    # Lazy-loading function for nvm
    nvm() {
        unset -f nvm claude
        _load_nvm
        nvm "$@"
    }

    # Lazy-loading function for claude (which is installed with nvm/node)
    claude() {
        unset -f nvm claude
        _load_nvm
        nvm use default >/dev/null 2>&1 || nvm use node >/dev/null 2>&1
        command claude "$@"
    }
fi

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# dvm (for deno)
[[ -d "$HOME/.dvm/bin" ]] && export PATH="$HOME/.dvm/bin:$PATH"

# Pulumi
[[ -d "$HOME/.pulumi/bin" ]] && export PATH="$HOME/.pulumi/bin:$PATH"

# .local/bin
[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"

# Bin
export PATH="$HOME/bin:$PATH"

# Go
export PATH="$HOME/go/bin:$PATH"

# https://github.com/gcoupelant/clone-helper
if which clone-helper >/dev/null; then
    function clone {
        source <(clone-helper -q $@)
    }
fi

# ZPlug
export ZPLUG_HOME=$(brew --prefix)/opt/zplug
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

# Completion
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit
