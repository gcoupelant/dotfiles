# WSL

When using WSL, a few tweaks are required.

## systemd

If you want to use `systemd` in WSL, add this to the `/etc/wsl.conf` file:

```conf
[boot]
systemd=true
```

### Interop

If you get issues with interoperability with `systemd` enabled, you can try this solution: <https://github.com/microsoft/WSL/issues/8843#issuecomment-1337127239>

This has been fixed with <https://github.com/microsoft/WSL/releases/tag/2.5.1>.

## DNS

When using Fedora (from <https://github.com/WhitewaterFoundry/Fedora-Remix-for-WSL>), there's a misconfigured systemd-resolved setting:

In `/etc/systemd/resolved.conf`, the `Cache` entry should be set to `no-negative` to avoid issues with empty DNS responses being cached (see: <https://www.hydrogen18.com/blog/preventing-systemd-from-caching-non-existent-domains.html>)

## Host's SSH client (for 1Password SSH Agent)

To use the [1Password SSH Agent with WSL](https://developer.1password.com/docs/ssh/integrations/wsl/), you need to use the Windows' host `ssh.exe` program instead of Linux's native `ssh`. This can be done by running this stow:

```bash
stow -t ~ -vv wsl-ssh
```

This will configure `git` to use `ssh.exe` (if using this repository's [`.gitconfig`](git/.gitconfig#L15) file) and create this alias: `ssh="ssh.exe"`.

> This will prevent any keys present in `~/.ssh` to be used.
