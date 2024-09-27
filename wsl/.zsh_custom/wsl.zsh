# Windows host PATH
# System32
export PATH="/mnt/c/Windows/System32/:$PATH"
# VSCode
export PATH="/mnt/c/Users/$USER/AppData/Local/Programs/Microsoft VS Code/bin:$PATH"
# User bin
export PATH="/mnt/c/Users/$USER/bin:$PATH"

# 1Password CLI
if [ ! -z $(find /mnt/c/Users/$USER/AppData/Local/Microsoft/WinGet/Packages -name op.exe) ]; then
  alias op="$(find /mnt/c/Users/$USER/AppData/Local/Microsoft/WinGet/Packages -name op.exe)"
fi
