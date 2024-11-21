if [[ -n "$WSLENV" ]]; then
  # Windows host PATH if not added (ie: appendWindowsPath is false), this assumes Windows is installed on the C:\ drive
  if [[ ! $PATH == *"/System32"* ]]; then
    # System32
    export PATH="/mnt/c/Windows/System32/:$PATH"
    # VSCode
    export PATH="/mnt/c/Users/$USER/AppData/Local/Programs/Microsoft VS Code/bin:$PATH"
    # User bin
    export PATH="/mnt/c/Users/$USER/bin:$PATH"
  fi

  # 1Password CLI
  if [[ -d "/mnt/c/Users/$USER/AppData/Local/Microsoft/WinGet/Packages" ]]; then
    if [[ ! -z $(find /mnt/c/Users/$USER/AppData/Local/Microsoft/WinGet/Packages -name op.exe) ]]; then
      alias op="$(find /mnt/c/Users/$USER/AppData/Local/Microsoft/WinGet/Packages -name op.exe)"
    fi
  fi

  # Use wslview as browser if available
  if [[ -s "/usr/bin/wslview" ]]; then
    export BROWSER=/usr/bin/wslview
  fi
fi
