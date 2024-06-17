# Import functions used in both profiles
. "H:\Users\NRevi\Powershell\profile_helpers.ps1"
Write-Host "Debug: Imported profile_helpers.ps1"

# Setting the STARSHIP_CONFIG environment variable to the specified path.
$ENV:STARSHIP_CONFIG = "H:\Users\NRevi\Powershell\Starship\.config\starship.toml"
Write-Host "Debug: Set STARSHIP_CONFIG to $ENV:STARSHIP_CONFIG"

# Specifying the STARSHIP_DISTRO to the hostname of the system.
$ENV:STARSHIP_DISTRO = "$env:COMPUTERNAME"

# # Specifying the STARSHIP_DISTRO to the hostname of the system.
# $ENV:STARSHIP_DISTRO = "$hostname"
# Write-Host "Debug: Set STARSHIP_DISTRO to $ENV:STARSHIP_DISTRO"

$ENV:Home = "H:\Users\NRevi\"
Write-Host "Debug: Set Home to $ENV:Home"

function cdhome {
    Set-Location $env:Home
}

# Define the Get-DriveL function
# function Get-DriveL {
#     Write-Host "Debug: Get-DriveL function called"
#     (Get-Location).Drive.Name
# }
# Write-Host "Debug: Defined Get-DriveL function"

# Call the Get-DriveL function and set the environment variable
# if (Get-DriveL) {
#     $ENV:drive = Get-DriveL
#     Write-Host "Debug: Set ENV:drive to $ENV:drive"
# } else {
#     Write-Host "Debug: Get-DriveL function returned no value"
# }

# Initializing Starship with the PowerShell shell.
Invoke-Expression (&starship init powershell)
Write-Host "Debug: Initialized Starship"


# Defining a function for Scoop.
function scoop {
    Write-Host "Debug: Scoop function called with args $args"
    if ($args[0] -eq "search") {
        scoop-search-multisource.exe @($args | Select-Object -Skip 1)
    }
    else {
        scoop.ps1 @args
    }
}
Write-Host "Debug: Defined Scoop function"

# Initializing Conda environment.
$Env:CONDA_EXE = "C:\ProgramData\miniconda3\Scripts\conda.exe"
# $Env:_CE_M = ""
# $Env:_CE_CONDA = ""
$Env:_CONDA_ROOT = "C:\ProgramData\miniconda3"
$Env:_CONDA_EXE = "C:\ProgramData\miniconda3\Scripts\conda.exe"
Write-Host "Debug: Set Conda environment variables"

$CondaModuleArgs = @{ChangePs1 = $True }
Import-Module "$Env:_CONDA_ROOT\shell\condabin\Conda.psm1" -ArgumentList $CondaModuleArgs
Write-Host "Debug: Imported Conda module"

conda activate base
Write-Host "Debug: Activated Conda base environment"

Remove-Variable CondaModuleArgs
Write-Host "Debug: Removed CondaModuleArgs variable"

# Importing and setting up the alias section, various modules, utilities, scripts, and other functions.
Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1
Write-Host "Debug: Imported Chocolatey profile module"

Import-Module z
Write-Host "Debug: Imported z module"%

# Import-Module gsudoModule.psd1
# Write-Host "Debug: Imported gsudo module"


# Setting aliases for ease of use in PowerShell.
Set-Alias -Name ~ -Value cdhome
Set-Alias -Name ip -Value ipconfig
Set-Alias -Name dc -Value docker-compose
Set-Alias -Name dig -Value nslookup
Set-Alias -Name gcc -Value gitclone
Set-Alias -Name gccc -Value gccc
Set-Alias -Name editor -Value code
Set-Alias -Name edit -Value editor
Set-Alias -Name profile -Value profile_alias
Set-Alias -Name reload -Value reload_alias
Set-Alias -Name sudo -Value gsudo
Write-Host "Debug: Set aliases"

# Defining various functions for ease of use in PowerShell.
function mkdir { 
    Write-Host "Debug: mkdir function called with args $args"
    New-Item "$args" -ItemType Directory 
}
function GoAdmin { 
    Write-Host "Debug: GoAdmin function called"
    Start-Process pwsh –Verb RunAs 
}
function touch { 
    Write-Host "Debug: touch function called with args $args"
    New-Item "$args" -ItemType File 
}
function home { 
    Write-Host "Debug: home function called"
    Set-Location "H:\Users\NRevi" 
}
function ipall { 
    Write-Host "Debug: ipall function called"
    ipconfig /all 
}
function gccc { 
    Write-Host "Debug: gccc function called with args $args"
    git clone "$args" 
}
function gitclone { 
    Write-Host "Debug: gitclone function called with args $args"
    git clone "$args" 
}
function reload_alias { 
    Write-Host "Debug: reload_alias function called"
    & . $PROFILE 
}
function profile_alias { 
    Write-Host "Debug: profile_alias function called"
    code $PROFILE 
}

# Setting a key handler for F7 to show command history in a GUI grid view.
Set-PSReadLineKeyHandler -Key F7 -BriefDescription History -LongDescription 'Show command history' -ScriptBlock {
    Write-Host "Debug: F7 key handler activated"
    $pattern = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$pattern, [ref]$null)
    if ($pattern) {
        $pattern = [regex]::Escape($pattern)
    }

    $history = Get-History | Where-Object { $_.CommandLine -match $pattern } | Sort-Object -Property Id -Unique
    $command = $history | Out-GridView -Title History -PassThru
    if ($command) {
        [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
        [Microsoft.PowerShell.PSConsoleReadLine]::Insert($command.CommandLine)
    }
}

# # Setting a key handler for Alt+a to cycle through arguments on the command line.
# Set-PSReadLineKeyHandler -Key "Alt+a" `
# -BriefDescription "SelectCommandArguments" `
# -LongDescription "Set current selection to next command argument in the command line." `
# -ScriptBlock {
#     param($key, $arg)
#     Write-Host "Debug: Alt+a key handler activated"
#     # Logic to handle cycling through command line arguments.
# }

# Setting PSReadLine options for prediction and edit mode.
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows
Write-Host "Debug: Set PSReadLine options"

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
    Write-Host "Debug: Imported Chocolatey profile module"
}

# PowerToys CommandNotFound module
Import-Module "H:\Users\NRevi\OneDrive\Documents\PowerShell\Modules\Microsoft.WinGet.CommandNotFound\Microsoft.WinGet.CommandNotFound.psd1"
Write-Host "Debug: Imported PowerToys CommandNotFound module"
#f45873b3-b655-43a6-b217-97c00aa0db58 PowerToys CommandNotFound module

# Import-Module -Name Microsoft.WinGet.CommandNotFound
#f45873b3-b655-43a6-b217-97c00aa0db58
