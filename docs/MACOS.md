# MacOS

## Dock

On MacOS, run the following command the make the Dock appears faster:
```
defaults write com.apple.dock autohide-delay -int 0
defaults write com.apple.dock autohide-time-modifier -float 0.4
killall Dock
```

To revert it, you can these:
```
defaults delete com.apple.dock autohide-delay
defaults delete com.apple.dock autohide-time-modifier
killall Dock
```
