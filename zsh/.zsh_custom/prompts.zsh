# Print status (error code)
print_status() {
retVal=$?
if [[ $retVal -ne 0 ]]; then
    echo "Exit code: ${retVal}"
fi
}
# Make sure it's not added multiple times in case of re-sourcing for .zshrc
if ! [[ " $precmd_functions " =~ .*\ print_status\ .* ]]; then
  precmd_functions+=(print_status)
fi

# kubectl
# Kube PS1
source "$(brew --prefix)/opt/kube-ps1/share/kube-ps1.sh"
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

# Check if DISABLE_KUBE_PS1_UNTIL_KUBECTL is set to "true". If yes, disable kube-ps1 until kubectl is used
if [[  "$DISABLE_KUBE_PS1_UNTIL_KUBECTL" = "true" ]]; then
    # Hide kube-ps1 first
    kubeoff
    # Wrap kubectl to enable kube-ps1 on the first run
    kubectl() {
        if [[ -z "$_KUBECTL_USED" ]]; then
            kubeon
            export _KUBECTL_USED=true
        fi
        command kubectl "$@"  # Call the real kubectl command
    }
fi

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
