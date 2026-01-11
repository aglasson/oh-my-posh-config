# PowerShell Profile with Oh My Posh
# Place this file in your PowerShell profile location
# Find location with: $PROFILE

# Oh My Posh Configuration
$ompConfig = "$HOME\oh-my-posh-config\themes\personal.omp.json"
if (Test-Path $ompConfig) {
    oh-my-posh init pwsh --config $ompConfig | Invoke-Expression
} else {
    Write-Host "Oh My Posh config not found at: $ompConfig" -ForegroundColor Yellow
    Write-Host "Please clone the oh-my-posh-config repository to your home directory" -ForegroundColor Yellow
}

# PSReadLine Configuration for better command line editing
if (Get-Module -ListAvailable -Name PSReadLine) {
    Import-Module PSReadLine
    
    # Prediction settings
    Set-PSReadLineOption -PredictionSource History
    Set-PSReadLineOption -PredictionViewStyle ListView
    
    # Editing mode
    Set-PSReadLineOption -EditMode Windows
    
    # Key handlers
    Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
    Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
    Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
    
    # Colors
    Set-PSReadLineOption -Colors @{
        Command            = 'Yellow'
        Parameter          = 'Green'
        Operator           = 'Magenta'
        Variable           = 'White'
        String             = 'Cyan'
        Number             = 'White'
        Type               = 'Gray'
        Comment            = 'DarkGray'
    }
}

# Custom Aliases
Set-Alias -Name ll -Value Get-ChildItem -ErrorAction SilentlyContinue
Set-Alias -Name vim -Value nvim -ErrorAction SilentlyContinue
Set-Alias -Name g -Value git -ErrorAction SilentlyContinue

# Useful Functions
function which($command) {
    Get-Command -Name $command -ErrorAction SilentlyContinue | 
        Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

function touch($file) {
    "" | Out-File $file -Encoding ASCII
}

function mkcd($dir) {
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
    Set-Location $dir
}

# Navigation shortcuts
function .. { Set-Location .. }
function ... { Set-Location ..\.. }
function .... { Set-Location ..\..\.. }
function ~ { Set-Location ~ }

# Git shortcuts
function gs { git status }
function ga { git add $args }
function gc { git commit -m $args }
function gp { git push }
function gl { git log --oneline --graph --decorate }

# System information
function sysinfo {
    Write-Host "System Information" -ForegroundColor Cyan
    Write-Host "==================" -ForegroundColor Cyan
    Write-Host "OS: $([System.Environment]::OSVersion.VersionString)"
    Write-Host "PowerShell: $($PSVersionTable.PSVersion)"
    Write-Host "Computer: $env:COMPUTERNAME"
    Write-Host "User: $env:USERNAME"
    Write-Host "Home: $HOME"
}

# Profile reload
function Reload-Profile {
    . $PROFILE
    Write-Host "Profile reloaded!" -ForegroundColor Green
}
Set-Alias -Name reload -Value Reload-Profile

# Welcome message (optional - comment out if not desired)
$greeting = if ((Get-Date).Hour -lt 12) { "Good morning" } 
            elseif ((Get-Date).Hour -lt 18) { "Good afternoon" } 
            else { "Good evening" }
Write-Host "$greeting, $env:USERNAME! " -NoNewline -ForegroundColor Cyan
Write-Host "PowerShell $($PSVersionTable.PSVersion) with Oh My Posh" -ForegroundColor DarkCyan
