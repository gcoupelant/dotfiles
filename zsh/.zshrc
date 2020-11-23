# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="ys-wsl-2"

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
plugins=(fzf git kubectl)

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

[ -f ~/.bash_aliases ] && source ~/.bash_aliases
[ -f ~/.bash_env_var ] && source ~/.bash_env_var
[ -f ~/.bash_secrets ] && source ~/.bash_secrets

# kubectl
# Lazy loading of kubectl completion
export KUBECTL_USED=false
export KUBE_PROMPT=""
function kubectl() {
    if [[ "$KUBECTL_USED" = false ]]; then
        export KUBECTL_USED=true
        # Kube PS1
        source "$HOMEBREW_PREFIX/opt/kube-ps1/share/kube-ps1.sh"
        export KUBE_PS1_PREFIX="\n🐳 "
        export KUBE_PS1_SUFFIX=""
        export KUBE_PS1_DIVIDER=" on "
        export KUBE_PS1_SYMBOL_ENABLE=false
        export KUBE_PS1_CTX_COLOR=blue
        export KUBE_PS1_NS_COLOR=red
        export KUBE_PROMPT='$(
            kube_ps1 |
            perl -pe "s/gke_(\S+)_(\S+)_(\S+) /[GKE] \1 \/ \3 %{%f%}in %{%F{cyan}%}\2%{%f%} /" |
            perl -pe "s/arn:aws:eks:(\S+):(\S+):cluster\/(\S+) /[EKS] \3 %{%f%}in %{%F{cyan}%}\1%{%f%} /"
        )'

    fi

    command kubectl "$@"
}

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Bin
export PATH="$HOME/bin:$PATH"

# Go
export PATH="$HOME/go/bin:$PATH"

# Pipenv
export PIPENV_VENV_IN_PROJECT=1
function py_info(){
    # Get Virtual Env
    if [[ -n "$VIRTUAL_ENV" ]]; then
        # Strip out the path and just leave the env name
            py=$(python --version 2>&1)
        echo "\n🐍 %{%F{green}%}$py%{%f%} on %{%F{magenta}%}${VIRTUAL_ENV##*/}%{%f%}"
    fi
}

# Disable the default virtualenv prompt change and replace with custom one
export VIRTUAL_ENV_DISABLE_PROMPT=1
export PROMPT='$(py_info)'$PROMPT

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
