# Oh-My-Posh Configuration

My personal [Oh My Posh](https://ohmyposh.dev/) configuration, custom theme, and related utilities for terminal customization.

![License](https://img.shields.io/badge/license-MIT-blue.svg)

## 📁 Repository Structure

```
oh-my-posh-config/
├── themes/                           # Oh My Posh theme files
│   └── personal.omp.json            # Personal theme (based on default)
├── scripts/                          # Utility scripts
│   ├── deploy-profile.ps1           # PowerShell profile deployment script
│   └── Microsoft.PowerShell_profile.ps1  # Sample PowerShell profile
├── docs/                             # Documentation
│   ├── vscode-setup.md              # VSCode integration guide
│   └── powershell-profile.md        # PowerShell profile configuration
└── .github/
    └── copilot-instructions.md      # GitHub Copilot instructions
```

## 🚀 Quick Start

### Prerequisites

1. **Install Oh My Posh**

   **Windows:**
   ```powershell
   winget install JanDeDobbeleer.OhMyPosh -s winget
   ```

   **macOS:**
   ```bash
   brew install jandedobbeleer/oh-my-posh/oh-my-posh
   ```

   **Linux:**
   ```bash
   curl -s https://ohmyposh.dev/install.sh | bash -s
   ```

2. **Install a Nerd Font**
   ```powershell
   oh-my-posh font install
   ```
   
   Choose a font like **CascadiaCode Nerd Font** and configure your terminal to use it.

### Installation

1. **Clone this repository:**
   ```powershell
   cd ~
   git clone https://github.com/<your-username>/oh-my-posh-config.git
   # Or if you're the repo owner:
   # git clone https://github.com/aglasson/oh-my-posh-config.git
   ```

2. **Deploy PowerShell profile (Windows):**
   ```powershell
   cd oh-my-posh-config
   .\scripts\deploy-profile.ps1
   ```

3. **Or manually configure (any shell):**

   **PowerShell:**
   ```powershell
   # Add to $PROFILE
   oh-my-posh init pwsh --config "$HOME\oh-my-posh-config\themes\personal.omp.json" | Invoke-Expression
   ```

   **Bash:**
   ```bash
   # Add to ~/.bashrc
   eval "$(oh-my-posh init bash --config ~/oh-my-posh-config/themes/personal.omp.json)"
   ```

   **Zsh:**
   ```zsh
   # Add to ~/.zshrc
   eval "$(oh-my-posh init zsh --config ~/oh-my-posh-config/themes/personal.omp.json)"
   ```

4. **Restart your terminal**

## 🎨 Theme Features

The **personal.omp.json** theme includes:

- **Session segment**: Shows username and SSH indicator
- **Path segment**: Current directory with folder icon
- **Git segment**: Branch, status, changes, and stash count with color-coded backgrounds
- **Root indicator**: Warning when running as administrator
- **Exit status**: Visual success/failure indicator for commands
- **Right prompt**: Shows active language versions (Node.js, Python, Go, .NET) and current time

### Color Scheme

- Purple: Session/user info
- Pink: Current path
- Yellow/Orange: Git information (changes color based on status)
- Cyan/Red: Exit status (success/failure)
- Various: Language version indicators

## 📚 Documentation

- **[VSCode Setup Guide](docs/vscode-setup.md)**: Configure Oh My Posh in Visual Studio Code
- **[PowerShell Profile Guide](docs/powershell-profile.md)**: Comprehensive PowerShell profile configuration
- **[GitHub Copilot Instructions](.github/copilot-instructions.md)**: Guidelines for AI-assisted development

## 🛠️ Customization

### Modify the Theme

1. Edit `themes/personal.omp.json`
2. Validate your changes:
   ```powershell
   oh-my-posh config validate --config ./themes/personal.omp.json
   ```
3. Test in a new terminal session
4. Commit your changes

### Add Custom Segments

Refer to the [Oh My Posh Segments documentation](https://ohmyposh.dev/docs/segments/overview) for available segment types.

Example segments you can add:
- **battery**: Show battery status
- **terraform**: Show Terraform workspace
- **kubectl**: Show Kubernetes context
- **aws**: Show AWS profile
- **az**: Show Azure subscription

### Create Additional Themes

1. Copy `themes/personal.omp.json` to a new file (e.g., `work.omp.json`)
2. Customize colors, segments, and layout
3. Switch themes by changing the config path in your profile

## 🔧 Utilities

### Deploy Profile Script

The `deploy-profile.ps1` script automates PowerShell profile setup:

```powershell
# Standard deployment
.\scripts\deploy-profile.ps1

# Create backup of existing profile
.\scripts\deploy-profile.ps1 -Backup

# Skip module installation
.\scripts\deploy-profile.ps1 -SkipModules

# Force overwrite existing profile
.\scripts\deploy-profile.ps1 -Force
```

### Sample Profile

The `Microsoft.PowerShell_profile.ps1` includes:
- Oh My Posh initialization
- PSReadLine configuration for better editing
- Useful aliases (ll, vim, g)
- Helper functions (which, touch, mkcd)
- Git shortcuts (gs, ga, gc, gp, gl)
- Navigation shortcuts (.., ..., ....)
- System information function

## 🐛 Troubleshooting

### Icons Not Displaying

**Problem:** Seeing boxes or question marks instead of icons

**Solution:**
1. Verify Nerd Font is installed
2. Configure your terminal to use the Nerd Font
3. Restart terminal after font changes

### Theme Not Loading

**Problem:** Theme doesn't appear

**Solution:**
```powershell
# Check Oh My Posh version
oh-my-posh --version

# Validate theme
oh-my-posh config validate --config ./themes/personal.omp.json

# Test theme directly
oh-my-posh init pwsh --config ./themes/personal.omp.json | Invoke-Expression
```

### Slow Prompt

**Problem:** Terminal feels sluggish

**Solution:**
1. Disable git status fetch for large repositories
2. Reduce number of segments
3. Use `console_title_template: false`

See [PowerShell Profile documentation](docs/powershell-profile.md) for more troubleshooting tips.

## 🤝 Contributing

This is a personal configuration repository, but feel free to:
- Fork and customize for your own use
- Submit issues for bugs or questions
- Suggest improvements via pull requests

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🔗 Resources

- [Oh My Posh Official Documentation](https://ohmyposh.dev/)
- [Oh My Posh GitHub Repository](https://github.com/JanDeDobbeleer/oh-my-posh)
- [Nerd Fonts](https://www.nerdfonts.com/)
- [PowerShell Documentation](https://docs.microsoft.com/en-us/powershell/)
- [PSReadLine Documentation](https://docs.microsoft.com/en-us/powershell/module/psreadline/)

## 🌟 Acknowledgments

- Theme based on the [Oh My Posh default theme](https://github.com/JanDeDobbeleer/oh-my-posh/blob/main/themes/default.omp.json)
- Inspired by the Oh My Posh community themes

---

**Enjoy your beautiful terminal! 🎉**
