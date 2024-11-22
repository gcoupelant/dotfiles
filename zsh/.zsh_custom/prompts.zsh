# kubectl
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
    perl -pe "s/arn:aws:eks:(\S+):(\S+):cluster\/(\S+) /[EKS] \3 %{%f%}in %{%F{cyan}%}\2 (\1)%{%f%} /"
)'

# Pipenv
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
export TOP_PROMPT='$(py_info)'
