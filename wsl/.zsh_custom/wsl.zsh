if [[ -n "$WSLENV" ]]; then
  # Windows username
  win_user_home=$(wslpath "$(wslvar USERPROFILE)")

  # Windows host PATH if not added (ie: appendWindowsPath is false), this assumes Windows is installed on the C:\ drive
  if [[ ! $PATH == *"/System32"* ]]; then
    # System32
    export PATH="/mnt/c/Windows/System32/:$PATH"
    # VSCode
    export PATH="${win_user_home}/AppData/Local/Programs/Microsoft VS Code/bin:$PATH"
    # User bin
    export PATH="${win_user_home}/bin:$PATH"
  fi

  # Keep the current path when duplicating a pane/tab
  keep_current_path() {
    printf "\e]9;9;%s\e\\" "$(wslpath -w "$PWD")"
  }
  precmd_functions+=(keep_current_path)

  # 1Password CLI
  if [[ -d "${win_user_home}/AppData/Local/Microsoft/WinGet/Packages" ]]; then
    if [[ ! -z $(find ${win_user_home}/AppData/Local/Microsoft/WinGet/Packages -name op.exe) ]]; then
      alias op="$(find ${win_user_home}/AppData/Local/Microsoft/WinGet/Packages -name op.exe)"
    fi
  fi

  # Ollama
  if [[ -s "${win_user_home}/AppData/Local/Programs/Ollama/ollama.exe" ]]; then
    alias ollama="${win_user_home}/AppData/Local/Programs/Ollama/ollama.exe"
  fi

  # Use wslview as browser if available
  if [[ -s "/usr/bin/wslview" ]]; then
    export BROWSER=/usr/bin/wslview
  fi
fi
