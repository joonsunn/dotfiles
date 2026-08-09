# VS Code stow notes

## VS Code folder shenanigans

VS Code settings are excluded from global stow (using `--ignore vscode`) since VS Code stores settings in platform-specific locations. Use the `-t` flag to specify the correct target:

- **MacOS:** `~/Library/Application Support/Code/User`
- **Linux:** `~/.config/Code/User`

To stow:

**On MacOS:**

```bash
stow --verbose --target="$HOME/Library/Application\ Support/Code/User" --stow vscode
```

**On Linux:**

```bash
stow --verbose --target="$HOME/.config/Code/User" --stow vscode
```
