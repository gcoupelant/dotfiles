# ~/.bash_aliases: executed by bash(1) for non-login shells.

# Directory
#alias ls="ls -hF --color=auto"
alias ll="ls --color=auto -lh"
alias la="ls --color=auto -la"
alias l="ls --color=auto -CF"
function mkd() { mkdir -p "$@" && cd "$_"; }

alias d="cd ~/dev"

# Miscellaneous
#alias c="clear"
alias up="cd .."
alias up2="cd ../.."
alias up3="cd ../../.."
alias up4="cd ../../../.."
alias up5="cd ../../../../.."
alias grep="grep --color"

# Git
alias gpl="git pull"
alias gs="git status"
alias gco="git checkout"
alias gcb="git checkout -b"

# Homebrew
alias bubu="brew update && brew upgrade"

alias sed="gsed"
alias gzip="ggzip"
alias tar="gtar"
alias which="gwhich"

# App shorts
alias dk="docker"

alias k="kubectl"
alias kctx="kubectx"
alias kns="kubens"
alias h="helm"
alias hl="helm list"
alias tf="terraform"

alias ws="/usr/local/bin/webstorm ."
alias pc="/usr/local/bin/charm ."

# Helm
alias helm2="/usr/local/opt/helm@2/bin/helm"
alias helm3="/usr/local/opt/helm/bin/helm"
alias helmfile="helmfile --helm-binary /usr/local/opt/helm/bin/helm"