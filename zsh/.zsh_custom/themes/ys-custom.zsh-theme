# Clean, simple, compatible and meaningful.
# Tested on Linux, Unix and Windows under ANSI colors.
# It is recommended to use with a dark background.
# Colors: black, red, green, yellow, *blue, magenta, cyan, and white.
#
# Mar 2013 Yad Smood

source /etc/os-release

local prompt_host=$([ ! -z "${WSL_DISTRO_NAME}" ] && echo "WSL-$WSL_DISTRO_NAME-$VERSION_ID" || echo "$HOSTNAME")

### Git [±master ▾●]

ZSH_THEME_GIT_PROMPT_PREFIX=" "
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}✔%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[cyan]%}▴%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg[magenta]%}▾%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg_bold[green]%}●%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNSTAGED="%{$fg_bold[yellow]%}●%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}●%{$reset_color%}"

git_info () {
  local ref
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  echo "${ref#refs/heads/}"
}

git_status() {
  local result gitstatus
  gitstatus="$(command git status --porcelain -b 2>/dev/null)"

  # check status of files
  local gitfiles="$(tail -n +2 <<< "$gitstatus")"
  if [[ -n "$gitfiles" ]]; then
    if [[ "$gitfiles" =~ $'(^|\n)[AMRD]. ' ]]; then
      result+="$ZSH_THEME_GIT_PROMPT_STAGED"
    fi
    if [[ "$gitfiles" =~ $'(^|\n).[MTD] ' ]]; then
      result+="$ZSH_THEME_GIT_PROMPT_UNSTAGED"
    fi
    if [[ "$gitfiles" =~ $'(^|\n)\\?\\? ' ]]; then
      result+="$ZSH_THEME_GIT_PROMPT_UNTRACKED"
    fi
    if [[ "$gitfiles" =~ $'(^|\n)UU ' ]]; then
      result+="$ZSH_THEME_GIT_PROMPT_UNMERGED"
    fi
  else
    result+="$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi

  # check status of local repository
  local gitbranch="$(head -n 1 <<< "$gitstatus")"
  if [[ "$gitbranch" =~ '^## .*ahead' ]]; then
    result+="$ZSH_THEME_GIT_PROMPT_AHEAD"
  fi
  if [[ "$gitbranch" =~ '^## .*behind' ]]; then
    result+="$ZSH_THEME_GIT_PROMPT_BEHIND"
  fi
  if [[ "$gitbranch" =~ '^## .*diverged' ]]; then
    result+="$ZSH_THEME_GIT_PROMPT_DIVERGED"
  fi

  # check if there are stashed changes
  if command git rev-parse --verify refs/stash &> /dev/null; then
    result+="$ZSH_THEME_GIT_PROMPT_STASHED"
  fi

  echo $result
}

git_prompt() {
  # check git information
  local gitinfo=$(git_info)
  if [[ -z "$gitinfo" ]]; then
    return
  fi

  # quote % in git information
  local output="${gitinfo:gs/%/%%}"

  # check git status
  local gitstatus=$(git_status)
  if [[ -n "$gitstatus" ]]; then
    output+=" $gitstatus"
  fi

  echo "${ZSH_THEME_GIT_PROMPT_PREFIX}${output}${ZSH_THEME_GIT_PROMPT_SUFFIX}"
}

local exit_code="%(?,,C:%{$fg[red]%}%?%{$reset_color%})"

local top_right="[%*]"

local pwd_prompt="> %{$fg[yellow]%}%~%{$reset_color%}"

local cmd_prompt="%{$fg[red]%}$ %{$reset_color%}"

# return_code="%(?..C:%{$fg[red]%}%?%{$reset_color%})"

function get_prompt {
  (( spare_width = ${COLUMNS} - 1 ))
  prompt=" "

  user_machine_size=${#${(%):-X %n @ ${prompt_host}-}}
  hour_size=${#${(%):-[%*]}}

  (( spare_width = ${spare_width} - (${user_machine_size} + ${hour_size}) ))

  while [ ${#prompt} -lt $spare_width ]; do
    prompt=" $prompt"
  done

  prompt="%{$fg[blue]%}#%{$reset_color%} \
%(#,%{$bg[yellow]%}%{$fg[black]%}%n%{$reset_color%},%{$fg[cyan]%}%n) \
%{$reset_color%}@ \
%{$fg[green]%}$prompt_host \
%{$reset_color%}\
$prompt\
%{[%*]%}\

${pwd_prompt}"

  echo $prompt
}

function get_kube_prompt {
  print -rP ${KUBE_PROMPT}
}
function get_top_prompt {
  print -rP ${TOP_PROMPT}
}

setopt prompt_subst
PROMPT='$(get_top_prompt)$(get_kube_prompt)
$(get_prompt)
${cmd_prompt}'
RPROMPT='%{$(echotc UP 1)%}$(git_prompt)%{$(echotc DO 1)%}'
