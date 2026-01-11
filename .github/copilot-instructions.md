# GitHub Copilot Instructions for oh-my-posh-config

This repository contains personal oh-my-posh configuration, themes, and related utilities.

## Repository Structure

- `themes/` - Contains oh-my-posh theme JSON files
  - `personal.omp.json` - Main personal theme based on oh-my-posh default
- `docs/` - Documentation and setup instructions
  - `vscode-setup.md` - VSCode integration instructions
  - `powershell-profile.md` - PowerShell profile configuration
- `scripts/` - Utility scripts for deployment and setup
- `.github/` - GitHub-specific files including these Copilot instructions

## Theme Development Guidelines

When working with oh-my-posh themes:

1. **JSON Schema**: Always use the oh-my-posh schema for validation:
   ```json
   "$schema": "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json"
   ```

2. **Theme Structure**:
   - Themes use `blocks` containing `segments`
   - Each segment has a `type` (e.g., path, git, session, exit)
   - Segments support templates using Go templating syntax
   - Powerline symbols: `\ue0b0`, `\ue0b4`, `\ue0b6` for transitions

3. **Color Guidelines**:
   - Use hex colors for consistency
   - Support both light and dark terminal themes where possible
   - Use `background_templates` for conditional coloring

4. **Icons and Symbols**:
   - Use Nerd Font symbols for icons (e.g., `\ue0a0` for git branch)
   - Test icons render correctly in target terminals
   - Common icons: git `\ue0a0`, folder `\ue5ff`, error `\uf00d`, success `\uf00c`

## Documentation Standards

- Keep instructions clear and step-by-step
- Include both Windows and Unix/Linux variations where applicable
- Provide example commands and expected outputs
- Link to official oh-my-posh documentation for detailed information

## Code Quality

- Format JSON with 2-space indentation
- Validate theme files before committing
- Test themes in multiple terminal environments (PowerShell, bash, zsh)
- Document any custom segments or advanced features

## Useful Commands

```powershell
# Test theme in PowerShell
oh-my-posh init pwsh --config ./themes/personal.omp.json | Invoke-Expression

# Validate theme JSON
oh-my-posh config validate --config ./themes/personal.omp.json

# Export theme to PNG for preview
oh-my-posh config export image --config ./themes/personal.omp.json --output preview.png
```

## Resources

- [Oh My Posh Documentation](https://ohmyposh.dev/)
- [Theme Configuration Guide](https://ohmyposh.dev/docs/configuration/overview)
- [Segment Types](https://ohmyposh.dev/docs/segments/overview)
- [Nerd Fonts](https://www.nerdfonts.com/)
