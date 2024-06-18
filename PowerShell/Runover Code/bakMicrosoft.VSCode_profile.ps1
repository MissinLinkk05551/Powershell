# Setting the STARSHIP_CONFIG environment variable to the specified path.
# Specifying the STARSHIP_DISTRO to the hostname of the system.

$ENV:STARSHIP_CONFIG = "H:\Users\NRevi\Powershell\Starship\.config\starship.toml"

$ENV:STARSHIP_DISTRO = "[$hostname]"

$ENV:Home = "H:\Users\NRevi\"

function cdhome {
    Set-Location $env:Home
}

# Initializing Starship with the PowerShell shell.

Invoke-Expression (& 'C:\Program Files\starship\bin\starship.exe' init powershell --print-full-init | Out-String)

Invoke-Expression (& { (lua "H:\Users\NRevi\Powershell\Scripts\Clink\z.lua" --init powershell) -join "`n" })
# Defining a function for Scoop.

function scoop {
    if ($args[0] -eq "search") {
        scoop-search-multisource.exe @($args | Select-Object -Skip 1)
    }
    else {
        scoop.ps1 @args
    }
}

# Initializing Conda environment.

$Env:CONDA_EXE = "C:\ProgramData\miniconda3\Scripts\conda.exe"
$Env:_CE_M = ""
$Env:_CE_CONDA = ""
$Env:_CONDA_ROOT = "C:\ProgramData\miniconda3"
$Env:_CONDA_EXE = "C:\ProgramData\miniconda3\Scripts\conda.exe"

$CondaModuleArgs = @{ChangePs1 = $True }
Import-Module "$Env:_CONDA_ROOT\shell\condabin\Conda.psm1" -ArgumentList $CondaModuleArgs

conda activate base

Remove-Variable CondaModuleArgs


# # Importing and setting up the alias section, various modules, utilities, scripts, and other functions.

Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1

Import-Module gsudoModule.psd1

Import-Module z

# Setting aliases for ease of use in PowerShell.

set-alias -Name ~ -Value home

set-alias -Name ip -Value ipall

set-alias -Name dc -Value docker-compose

set-alias -Name dig -Value nslookup

set-alias -Name gcc -Value gitclone

set-alias -Name gccc -Value gccc

set-alias -Name va -Value venv

Set-Alias -Name editor -Value code

Set-Alias -Name edit -Value editor

Set-Alias -Name profile -Value profile_alias

Set-Alias -Name reload -Value reload_alias

Set-Alias -Name sudo -Value gsudo

# Defining various functions for ease of use in PowerShell.
function mkdir { New-Item "$args" -ItemType Directory } 
function GoAdmin { Start-Process pwsh –Verb RunAs }
function touch { New-Item "$args" -ItemType File }
function venv { .venv/scripts/activate.ps1 }
function home { H:\Users\NRevia05 }
function ipall { ipconfig /all }
function gccc { git clone $args }
function gitclone { git clone $args }
function reload_alias { & $PROFILE }
function profile_alias { editor $PROFILE }



# Setting a key handler for F7 to show command history in a GUI grid view.

Set-PSReadLineKeyHandler -Key F7 -BriefDescription History -LongDescription 'Show command history' -ScriptBlock {
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

# Setting a key handler for Alt+a to cycle through arguments on the command line.

Set-PSReadLineKeyHandler -Key "Alt+a" `
    -BriefDescription "SelectCommandArguments" `
    -LongDescription "Set current selection to next command argument in the command line." `
    -ScriptBlock {
    param($key, $arg)
        
    # Logic to handle cycling through command line arguments.
}

# Setting PSReadLine options for prediction and edit mode.

Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows