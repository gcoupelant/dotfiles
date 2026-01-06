# MacOS

## Dock

On MacOS, run the following command the make the Dock appears faster:

```bash
defaults write com.apple.dock autohide-delay -int 0
defaults write com.apple.dock autohide-time-modifier -float 0.4
killall Dock
```

To revert it, you can these:

```bash
defaults delete com.apple.dock autohide-delay
defaults delete com.apple.dock autohide-time-modifier
killall Dock
```

## TouchID for `sudo`

If you want to get prompted for TouchID when using `sudo` (instead of having to type your password), you can run the following command:

```bash
sed -e 's/^#auth/auth/' /etc/pam.d/sudo_local.template | sudo tee /etc/pam.d/sudo_local
```
