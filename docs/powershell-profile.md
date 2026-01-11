# PowerShell Profile Deployment Configuration

This document describes how to deploy and manage your PowerShell profile with oh-my-posh configuration.

## Quick Start

### Deploy Profile Configuration

1. **Clone this repository:**
   ```powershell
   cd ~
   git clone https://github.com/<your-username>/oh-my-posh-config.git
   # Or if you're using this repo as a reference:
   # git clone https://github.com/aglasson/oh-my-posh-config.git
   ```

2. **Run the deployment script:**
   ```powershell
   cd oh-my-posh-config
   .\scripts\deploy-profile.ps1
   ```

3. **Restart your PowerShell session**

## Manual Setup

If you prefer manual setup or want to customize:

### 1. Install Prerequisites

```powershell
# Install Oh My Posh
winget install JanDeDobbeleer.OhMyPosh -s winget

# Install a Nerd Font
oh-my-posh font install

# Optional: Install PSReadLine for better command line editing
Install-Module -Name PSReadLine -Force -SkipPublisherCheck
```

### 2. Configure PowerShell Profile

Locate your PowerShell profile:
```powershell
$PROFILE
```

Common locations:
- **Windows PowerShell:** `C:\Users\<username>\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1`
- **PowerShell Core:** `C:\Users\<username>\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`

Create the profile if it doesn't exist:
```powershell
if (!(Test-Path -Path $PROFILE)) {
    New-Item -ItemType File -Path $PROFILE -Force
}
```

### 3. Add Oh-My-Posh Initialization

Edit your profile:
```powershell
notepad $PROFILE
```

Add the following content:

```powershell
# Oh My Posh Configuration
$ompConfig = "$HOME\oh-my-posh-config\themes\personal.omp.json"
if (Test-Path $ompConfig) {
    oh-my-posh init pwsh --config $ompConfig | Invoke-Expression
} else {
    Write-Host "Oh My Posh config not found at: $ompConfig" -ForegroundColor Yellow
}

# PSReadLine Configuration (Optional but recommended)
if (Get-Module -ListAvailable -Name PSReadLine) {
    Import-Module PSReadLine
    Set-PSReadLineOption -PredictionSource History
    Set-PSReadLineOption -PredictionViewStyle ListView
    Set-PSReadLineOption -EditMode Windows
    Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
    Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
    Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
}

# Optional: Custom Aliases
Set-Alias -Name vim -Value nvim -ErrorAction SilentlyContinue
Set-Alias -Name ll -Value Get-ChildItem

# Optional: Useful Functions
function which($command) {
    Get-Command -Name $command -ErrorAction SilentlyContinue | 
        Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

function touch($file) {
    "" | Out-File $file -Encoding ASCII
}

function .. { Set-Location .. }
function ... { Set-Location ..\.. }
function .... { Set-Location ..\..\.. }
```

### 4. Reload Profile

```powershell
. $PROFILE
```

## Profile Structure

Your PowerShell profile can be organized as follows:

```
$PROFILE
├── Microsoft.PowerShell_profile.ps1    # Main profile
└── Scripts/                            # Custom scripts
    ├── aliases.ps1                     # Custom aliases
    ├── functions.ps1                   # Custom functions
    └── environment.ps1                 # Environment variables
```

To modularize your profile, use dot-sourcing:

```powershell
# In Microsoft.PowerShell_profile.ps1
$scriptPath = Split-Path -Parent $PROFILE

. "$scriptPath\Scripts\aliases.ps1"
. "$scriptPath\Scripts\functions.ps1"
. "$scriptPath\Scripts\environment.ps1"
```

## Deployment Script

The deployment script (`scripts/deploy-profile.ps1`) automates the setup process:

### Features:
- Checks for oh-my-posh installation
- Creates profile if it doesn't exist
- Backs up existing profile
- Installs required modules
- Configures oh-my-posh with personal theme
- Validates configuration

### Usage:
```powershell
# Standard deployment
.\scripts\deploy-profile.ps1

# With backup of existing profile
.\scripts\deploy-profile.ps1 -Backup

# Skip module installation
.\scripts\deploy-profile.ps1 -SkipModules

# Force reinstallation
.\scripts\deploy-profile.ps1 -Force
```

## Updating Configuration

### Update Oh-My-Posh

```powershell
winget upgrade JanDeDobbeleer.OhMyPosh
```

### Update Theme

```powershell
cd ~/oh-my-posh-config
git pull
. $PROFILE  # Reload profile
```

### Update Profile Configuration

1. Edit your theme or profile scripts in the repository
2. Commit changes
3. Push to GitHub
4. Pull changes on other machines
5. Reload profile

## Synchronizing Across Machines

### Method 1: Git Repository (Recommended)

1. Store your profile configuration in this git repository
2. Clone on each machine
3. Run deployment script
4. Pull updates regularly

### Method 2: Symlink Profile

Create a symlink from your profile to the repository:

```powershell
# Remove existing profile (backup first!)
$profileBackup = "$PROFILE.backup.$(Get-Date -Format 'yyyyMMdd-HHmmss').ps1"
Move-Item $PROFILE $profileBackup -ErrorAction SilentlyContinue

# Create symlink (requires admin privileges)
New-Item -ItemType SymbolicLink -Path $PROFILE -Target "$HOME\oh-my-posh-config\scripts\Microsoft.PowerShell_profile.ps1"
```

### Method 3: Cloud Sync

Place the repository in a cloud-synced folder (OneDrive, Dropbox, etc.) and create symlinks.

## Troubleshooting

### Profile Not Loading

**Check execution policy:**
```powershell
Get-ExecutionPolicy
```

If restricted, set to RemoteSigned:
```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Oh-My-Posh Not Found

**Verify installation:**
```powershell
oh-my-posh --version
```

**Check PATH:**
```powershell
$env:PATH -split ';' | Select-String "oh-my-posh"
```

**Reinstall if needed:**
```powershell
winget install JanDeDobbeleer.OhMyPosh -s winget --force
```

### Theme File Not Found

**Verify path:**
```powershell
Test-Path "$HOME\oh-my-posh-config\themes\personal.omp.json"
```

**Use absolute path if needed:**
```powershell
$ompConfig = "C:\Users\YourName\oh-my-posh-config\themes\personal.omp.json"
```

### Profile Errors on Startup

**Test profile manually:**
```powershell
. $PROFILE
```

**View detailed errors:**
```powershell
$Error[0] | Format-List -Force
```

## Best Practices

1. **Version Control:** Keep profile in git for history and sync
2. **Modular Design:** Split large profiles into separate files
3. **Error Handling:** Use `-ErrorAction SilentlyContinue` for optional features
4. **Documentation:** Comment your customizations
5. **Testing:** Test profile changes in a new PowerShell session
6. **Backup:** Keep backups before major changes
7. **Performance:** Minimize startup time by lazy-loading modules

## Advanced Configuration

### Conditional Loading

Load different configurations based on context:

```powershell
# Different theme for work vs personal
$isWorkMachine = $env:COMPUTERNAME -like "WORK-*"
$theme = if ($isWorkMachine) { "work.omp.json" } else { "personal.omp.json" }
$ompConfig = "$HOME\oh-my-posh-config\themes\$theme"
oh-my-posh init pwsh --config $ompConfig | Invoke-Expression
```

### Profile Loading Time

Measure profile load time:

```powershell
# Add at the start of $PROFILE
$profileStart = Get-Date

# Add at the end of $PROFILE
$profileEnd = Get-Date
$loadTime = ($profileEnd - $profileStart).TotalMilliseconds
Write-Host "Profile loaded in $loadTime ms" -ForegroundColor Cyan
```

## Resources

- [PowerShell Profile Documentation](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_profiles)
- [Oh My Posh Documentation](https://ohmyposh.dev/)
- [PSReadLine Documentation](https://docs.microsoft.com/en-us/powershell/module/psreadline/)
- [PowerShell Execution Policies](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies)
