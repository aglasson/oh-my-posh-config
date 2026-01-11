# VSCode Oh-My-Posh Setup Instructions

This guide will help you integrate oh-my-posh with Visual Studio Code's integrated terminal.

## Prerequisites

1. **Install Oh My Posh**
   
   **Windows (PowerShell):**
   ```powershell
   winget install JanDeDobbeleer.OhMyPosh -s winget
   ```

   **macOS/Linux:**
   ```bash
   brew install jandedobbeleer/oh-my-posh/oh-my-posh
   ```

   Or download from [oh-my-posh releases](https://github.com/JanDeDobbeleer/oh-my-posh/releases)

2. **Install a Nerd Font**
   
   Oh My Posh requires a [Nerd Font](https://www.nerdfonts.com/) to display icons properly.
   
   Popular choices:
   - **CascadiaCode Nerd Font** (recommended for VSCode)
   - **FiraCode Nerd Font**
   - **JetBrainsMono Nerd Font**

   **Windows:**
   ```powershell
   oh-my-posh font install
   ```
   
   Select a font from the interactive menu.

   **macOS/Linux:**
   Download from [Nerd Fonts releases](https://github.com/ryanoasis/nerd-fonts/releases)

## VSCode Terminal Configuration

### 1. Configure Terminal Font

Open VSCode settings (Ctrl+, or Cmd+,) and add:

```json
{
  "terminal.integrated.fontFamily": "CaskaydiaCove Nerd Font",
  "terminal.integrated.fontSize": 12
}
```

**Note:** Font name varies by Nerd Font installed. Common names:
- `CaskaydiaCove Nerd Font` (CascadiaCode)
- `FiraCode Nerd Font`
- `JetBrainsMono Nerd Font`

### 2. Configure PowerShell Profile (Windows)

1. Open PowerShell in VSCode terminal
2. Edit your PowerShell profile:
   ```powershell
   notepad $PROFILE
   ```
3. Add the following line:
   ```powershell
   oh-my-posh init pwsh --config 'path/to/themes/personal.omp.json' | Invoke-Expression
   ```
4. Save and restart terminal

**Tip:** Use absolute paths or place the theme in a standard location:
```powershell
# Example with absolute path
oh-my-posh init pwsh --config 'C:\Users\YourName\oh-my-posh-config\themes\personal.omp.json' | Invoke-Expression

# Or copy theme to oh-my-posh themes directory
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\personal.omp.json" | Invoke-Expression
```

### 3. Configure Bash/Zsh Profile (macOS/Linux)

**Bash (~/.bashrc or ~/.bash_profile):**
```bash
eval "$(oh-my-posh init bash --config ~/path/to/themes/personal.omp.json)"
```

**Zsh (~/.zshrc):**
```zsh
eval "$(oh-my-posh init zsh --config ~/path/to/themes/personal.omp.json)"
```

Reload your shell:
```bash
source ~/.bashrc  # or ~/.bash_profile for bash
source ~/.zshrc   # for zsh
```

## Troubleshooting

### Icons Not Displaying

**Problem:** Boxes or question marks instead of icons

**Solution:**
1. Verify Nerd Font is installed
2. Check VSCode terminal font setting matches installed font
3. Restart VSCode after font installation

### Theme Not Loading

**Problem:** Theme doesn't appear in terminal

**Solution:**
1. Verify oh-my-posh is in PATH:
   ```powershell
   oh-my-posh --version
   ```
2. Check theme file path is correct
3. Validate theme JSON:
   ```powershell
   oh-my-posh config validate --config ./themes/personal.omp.json
   ```

### Colors Look Wrong

**Problem:** Colors appear incorrect or washed out

**Solution:**
1. Check VSCode color theme compatibility
2. Try enabling true color support:
   ```json
   {
     "terminal.integrated.enablePersistentSessions": false
   }
   ```
3. Some themes work better with specific VSCode color themes

### Performance Issues

**Problem:** Terminal feels slow

**Solution:**
1. Disable git status fetch if in large repos:
   ```json
   {
     "fetch_status": false
   }
   ```
2. Reduce number of segments in theme
3. Use `console_title_template: false` to disable title updates

## Advanced Configuration

### Multiple Themes for Different Shells

You can use different themes per shell by configuring each profile separately:

**PowerShell ($PROFILE):**
```powershell
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\personal.omp.json" | Invoke-Expression
```

**Git Bash (~/.bashrc):**
```bash
eval "$(oh-my-posh init bash --config ~/themes/personal-bash.omp.json)"
```

### Custom VSCode Settings for Oh-My-Posh

```json
{
  "terminal.integrated.fontFamily": "CaskaydiaCove Nerd Font",
  "terminal.integrated.fontSize": 12,
  "terminal.integrated.lineHeight": 1.2,
  "terminal.integrated.cursorStyle": "line",
  "terminal.integrated.cursorBlinking": true,
  "terminal.integrated.rightClickBehavior": "default",
  "terminal.integrated.copyOnSelection": true
}
```

## Testing Your Setup

Open a new terminal in VSCode and verify:

1. **Prompt displays correctly** with icons and colors
2. **Git information** appears when in a git repository
3. **Path segment** shows current directory
4. **Exit status** indicator works (run a failing command)
5. **Programming language versions** display in right prompt (if applicable)

## Resources

- [Oh My Posh Documentation](https://ohmyposh.dev/)
- [VSCode Terminal Documentation](https://code.visualstudio.com/docs/terminal/basics)
- [Nerd Fonts Website](https://www.nerdfonts.com/)
- [Powerline Characters](https://github.com/ryanoasis/powerline-extra-symbols)
