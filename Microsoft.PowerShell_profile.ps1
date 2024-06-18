# $PROFILE = "H:\Users\NRevi\OneDrive\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
# Importing Helpers
. "H:\Users\NRevi\Powershell\profile_helpers.ps1"
Write-Host "Debug: Imported profile_helpers.ps1"

# Setting the STARSHIP_CONFIG environment variable to the specified path.
$ENV:STARSHIP_CONFIG = "H:\Users\NRevi\Powershell\Starship\.config\starship.toml"
Write-Host "Debug: Set STARSHIP_CONFIG to $ENV:STARSHIP_CONFIG"

# Specifying the STARSHIP_DISTRO to the hostname of the system.
$ENV:STARSHIP_DISTRO = "$env:COMPUTERNAME"

#Setting Home to H:
$ENV:Home = "H:\Users\NRevi\"
Write-Host "Debug: Set Home to $ENV:Home"

# Initializing Starship with the PowerShell shell.
Invoke-Expression (&starship init powershell)
Write-Host "Debug: Initialized Starship"

# PowerToys CommandNotFound module
Import-Module "H:\Users\NRevi\OneDrive\Documents\PowerShell\Modules\Microsoft.WinGet.CommandNotFound\Microsoft.WinGet.CommandNotFound.psd1"
Write-Host "Debug: Imported PowerToys CommandNotFound module"

Import-Module z
Write-Host "Debug: Imported z module"%

# Initial GitHub.com connectivity check with 1 second timeout
$canConnectToGitHub = Test-Connection github.com -Count 1 -Quiet -TimeoutSeconds 1

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~       CHOCOLATE        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
    Write-Host "Debug: Imported Chocolatey profile module"
}
# Importing and setting up the alias section, various modules, utilities, scripts, and other functions.
Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1
Write-Host "Debug: Imported Chocolatey profile module"
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~       CHOCOLATE        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~         CONDA          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
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
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~         CONDA          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Setup of Alias for pwsh ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~## 
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
Set-Alias -Name xpaste -Value xpaste_alias
Set-Alias -Name xcopyf -Value xcopy_alias
Set-Alias -Name xx -Value xpaste
Set-Alias -Name cc -Value xcopy
Set-Alias -Name uppro -Value UpdateAllShell
Set-Alias -Name rp -Value reload-profile
Write-Host "Debug: Set aliases"
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Setup of Alias for pwsh ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~## 
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ My Powershell Functions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~## 
# Defining various functions for ease of use in PowerShell.
function mkdir { 
    Write-Host "Debug: mkdir function called with args $args"
    New-Item "$args" -ItemType Directory 
}
function xpaste_alias { 
    Write-Host "Debug: xpaste function called with args $args"
    get-clipboard >  "$args"  
}
function xcopy_alias { 
    Write-Host "Debug: xcopy function called with args $args"
    Get-Content "$args" | Set-Clipboard   
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
function scoop {
    Write-Host "Debug: Scoop function called with args $args"
    if ($args[0] -eq "search") {
        scoop-search-multisource.exe @($args | Select-Object -Skip 1)
    }
    else {
        scoop.ps1 @args
    }
}
function cdhome {
    # Import Modules and External Profiles
    # Ensure Terminal-Icons module is installed before importing
    if (-not (Get-Module -ListAvailable -Name Terminal-Icons)) {
        Install-Module -Name Terminal-Icons -Scope CurrentUser -Force -SkipPublisherCheck
    }
    Import-Module -Name Terminal-Icons
    $ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
    if (Test-Path($ChocolateyProfile)) {
        Import-Module "$ChocolateyProfile"
    }
    Set-Location $env:Home
}
function UpdateAllShell {
    Update-PowerShell
    Update-Profile
}
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ My Powershell Functions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~## 
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  Chris Titus Functions  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
# Utility Functions
function Test-CommandExists {
    param($command)
    $exists = $null -ne (Get-Command $command -ErrorAction SilentlyContinue)
    return $exists
}
function Edit-Profile {
    vim $PROFILE.CurrentUserAllHosts
}
function touch($file) { "" | Out-File $file -Encoding ASCII }
function ff($name) {
    Get-ChildItem -recurse -filter "*${name}*" -ErrorAction SilentlyContinue | ForEach-Object {
        Write-Output "$($_.directory)\$($_)"
    }
}

# Network Utilities
function Get-PubIP { (Invoke-WebRequest http://ifconfig.me/ip).Content }

# System Utilities
function uptime {
    if ($PSVersionTable.PSVersion.Major -eq 5) {
        Get-WmiObject win32_operatingsystem | Select-Object @{Name='LastBootUpTime'; Expression={$_.ConverttoDateTime($_.lastbootuptime)}} | Format-Table -HideTableHeaders
    } else {
        net statistics workstation | Select-String "since" | ForEach-Object { $_.ToString().Replace('Statistics since ', '') }
    }
}
function reload-profile {
    & $profile
}
function unzip ($file) {
    Write-Output("Extracting", $file, "to", $pwd)
    $fullFile = Get-ChildItem -Path $pwd -Filter $file | ForEach-Object { $_.FullName }
    Expand-Archive -Path $fullFile -DestinationPath $pwd
}
function grep($regex, $dir) {
    if ( $dir ) {
        Get-ChildItem $dir | select-string $regex
        return
    }
    $input | select-string $regex
}
function df {
    get-volume
}
function sed($file, $find, $replace) {
    (Get-Content $file).replace("$find", $replace) | Set-Content $file
}
function which($name) {
    Get-Command $name | Select-Object -ExpandProperty Definition
}
function export($name, $value) {
    set-item -force -path "env:$name" -value $value;
}
function pkill($name) {
    Get-Process $name -ErrorAction SilentlyContinue | Stop-Process
}
function pgrep($name) {
    Get-Process $name
}
function head {
    param($Path, $n = 10)
    Get-Content $Path -Head $n
}
function tail {
    param($Path, $n = 10)
    Get-Content $Path -Tail $n
}

# Quick File Creation
function nf { param($name) New-Item -ItemType "file" -Path . -Name $name }

# Directory Management
function mkcd { param($dir) mkdir $dir -Force; Set-Location $dir }

### Quality of Life Aliases

# Navigation Shortcuts
function docs { Set-Location -Path $HOME\Documents }
function dtop { Set-Location -Path $HOME\Desktop }

# Quick Access to Editing the Profile
function ep { vim $PROFILE }

# Simplified Process Management
function k9 { Stop-Process -Name $args[0] }

# Enhanced Listing
function la { Get-ChildItem -Path . -Force | Format-Table -AutoSize }
function ll { Get-ChildItem -Path . -Force -Hidden | Format-Table -AutoSize }

# Git Shortcuts
function gs { git status }
function ga { git add . }
function gc { param($m) git commit -m "$m" }
function gp { git push }
function g { z Github }
function gcom {
    git add .
    git commit -m "$args"
}
function lazyg {
    git add .
    git commit -m "$args"
    git push
}

# Quick Access to System Information
function sysinfo { Get-ComputerInfo }

# Networking Utilities
function flushdns { Clear-DnsClientCache }

# Clipboard Utilities
function cpy { Set-Clipboard $args[0] }
function pst { Get-Clipboard }
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~     Chris Titus Functions     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~    POWERSHELL & PROFILE UPDATE  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
# Check for Profile Updates
function Update-Profile {
    if (-not $global:canConnectToGitHub) {
        Write-Host "Skipping profile update check due to GitHub.com not responding within 1 second." -ForegroundColor Yellow
        return
    }
    
    try {
        $url = "https://raw.githubusercontent.com/MissinLinkk05551/Powershell/main/Microsoft.PowerShell_profile.ps1"
        # $url = "https://raw.githubusercontent.com/ChrisTitusTech/powershell-profile/main/Microsoft.PowerShell_profile.ps1"
        $oldhash = Get-FileHash $PROFILE
        Invoke-RestMethod $url -OutFile "$env:temp/Microsoft.PowerShell_profile.ps1"
        $newhash = Get-FileHash "$env:temp/Microsoft.PowerShell_profile.ps1"
        if ($newhash.Hash -ne $oldhash.Hash) {
            Copy-Item -Path "$env:temp/Microsoft.PowerShell_profile.ps1" -Destination $PROFILE -Force
            Write-Host "Profile has been updated. Please restart your shell to reflect changes" -ForegroundColor Magenta
        }
    } catch {
        Write-Error "Unable to check for `$profile updates"
    } finally {
        Remove-Item "$env:temp/Microsoft.PowerShell_profile.ps1" -ErrorAction SilentlyContinue
    }
}


function Update-PowerShell {
    if (-not $global:canConnectToGitHub) {
        Write-Host "Skipping PowerShell update check due to GitHub.com not responding within 1 second." -ForegroundColor Yellow
        return
    }
    
    try {
        Write-Host "Checking for PowerShell updates..." -ForegroundColor Cyan
        $updateNeeded = $false
        $currentVersion = $PSVersionTable.PSVersion.ToString()
        $gitHubApiUrl = "https://api.github.com/repos/PowerShell/PowerShell/releases/latest"
        $latestReleaseInfo = Invoke-RestMethod -Uri $gitHubApiUrl
        $latestVersion = $latestReleaseInfo.tag_name.Trim('v')
        if ($currentVersion -lt $latestVersion) {
            $updateNeeded = $true
        }
        
        if ($updateNeeded) {
            Write-Host "Updating PowerShell..." -ForegroundColor Yellow
            winget upgrade "Microsoft.PowerShell" --accept-source-agreements --accept-package-agreements
            Write-Host "PowerShell has been updated. Please restart your shell to reflect changes" -ForegroundColor Magenta
        } else {
            Write-Host "Your PowerShell is up to date." -ForegroundColor Green
        }
    } catch {
        Write-Error "Failed to update PowerShell. Error: $_"
    }
}

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ POWERSHELL & PROFILE UPDATE ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~    PSReadLine     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
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

# Setting PSReadLine options for prediction and edit mode to Enhanced PowerShell Experience
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows
Set-PSReadLineOption -Colors @{
    Command = 'Yellow'
    Parameter = 'Green'
    String = 'DarkCyan'
}
Write-Host "Debug: Set PSReadLine options"
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~    PSReadLine     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~   Editor Set UP   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
# Editor Configuration
$EDITOR = if (Test-CommandExists cursor) { 'cursor' }
elseif (Test-CommandExists nvim) { 'nvim' }
elseif (Test-CommandExists pvim) { 'pvim' }
elseif (Test-CommandExists vim) { 'vim' }
elseif (Test-CommandExists vi) { 'vi' }
elseif (Test-CommandExists code) { 'code' }
elseif (Test-CommandExists notepad++) { 'notepad++' }
elseif (Test-CommandExists sublime_text) { 'sublime_text' }
else { 'notepad' }
Set-Alias -Name vim -Value $EDITOR
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~   Editor Set UP   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##


##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~      NOT USED     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
# # Admin Check and Prompt Customization
# $isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
# function prompt {
#     if ($isAdmin) { "[" + (Get-Location) + "] # " } else { "[" + (Get-Location) + "] $ " }
# }
# $adminSuffix = if ($isAdmin) { " [ADMIN]" } else { "" }
# $Host.UI.RawUI.WindowTitle = "PowerShell {0}$adminSuffix" -f $PSVersionTable.PSVersion.ToString()   
        # function hb {
        #     if ($args.Length -eq 0) {
        #         Write-Error "No file path specified."
        #         return
        #     }
            
        #     $FilePath = $args[0]
            
        #     if (Test-Path $FilePath) {
        #         $Content = Get-Content $FilePath -Raw
        #     } else {
        #         Write-Error "File path does not exist."
        #         return
        #     }
            
        #     $uri = "http://bin.christitus.com/documents"
        #     try {
        #         $response = Invoke-RestMethod -Uri $uri -Method Post -Body $Content -ErrorAction Stop
        #         $hasteKey = $response.key
        #         $url = "http://bin.christitus.com/$hasteKey"
        #         Write-Output $url
        #     } catch {
        #         Write-Error "Failed to upload the document. Error: $_"
        #     }


    # # Setting a key handler for Alt+a to cycle through arguments on the command line.
    # Set-PSReadLineKeyHandler -Key "Alt+a" `
    # -BriefDescription "SelectCommandArguments" `
    # -LongDescription "Set current selection to next command argument in the command line." `
    # -ScriptBlock {
    #     param($key, $arg)
    #     Write-Host "Debug: Alt+a key handler activated"
    #     # Logic to handle cycling through command line arguments.
    # }

# Import-Module gsudoModule.psd1
# Write-Host "Debug: Imported gsudo module"
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
# Import the Chocolatey Profile that contains the necessary code to enable tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion for `choco` will not function. See https://ch0.co/tab-completion for details.
        # }
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~      NOT USED     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##