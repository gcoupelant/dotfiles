# ~/.bash_aliases: executed by bash(1) for non-login shells.

# Directory
#alias ls="ls -hF --color=auto"
alias ll="ls --color=auto -lh"
alias la="ls --color=auto -la"
alias l="ls --color=auto -CF"
function mkd() { mkdir -p "$@" && cd "$_"; }

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

function h() { code  ~/src/github.com/gcoupelant/history/; }

# App shorts
alias k="kubectl"
alias kctx="kubectx"
alias kns="kubens"
alias tf="terraform"
