[custom.drivel]
description = "display drive letter"
command = "${env_var.get-drivel}"
format = "[$output]($style)"
style = "(bold bright orange)"
when = "true"

[env_var.is_drive_letter] # TODO: Turn this into a custom env_var once implemented
variable = "ISDRIVELETTER"
symbol   = ''
format   = "[$symbol$output](bold bright-yellow)"
# ---
function Set-DriveLetter {
    # Get the current drive letter
    $currentDriveLetter = (Get-Location).Drive.Name
    Write-Host "Debug: Current drive letter is $currentDriveLetter" -ForegroundColor Yellow

    # Check if the current drive letter is C, D, or H
    if ($currentDriveLetter -eq 'C') {
        $Env:Drive = 'C:'
    }
    elseif ($currentDriveLetter -eq 'D') {
        $Env:Drive = 'D:'
    }
    elseif ($currentDriveLetter -eq 'H') {
        $Env:Drive = 'H:'
    }
    else {
        # If the drive letter is not C, D, or H, set it to the current drive letter
        $Env:Drive = "${currentDriveLetter}:"
    }
    
    Write-Host "Debug: Set ENV:Drive to $Env:Drive" -ForegroundColor Green
}

if (Set-DriveLetter) {
    $ENV:ISDRIVELETTER =  'just needs to be set, never displayed'
    Write-Host "Debug: Just needs to be set"
}
function Get-DriveL {

    # Get the current drive letter
    $currentDriveLetter = (Get-Location).Drive.Name
    Write-Host "Debug: Current drive letter is $currentDriveLetter" -ForegroundColor Yellow
    
    # Check if the current drive letter is C, D, or H
    if ($currentDriveLetter) {
        # If the drive letter is not C, D, or H, set it to the current drive letter
         $currentDriveLetter = (Get-Location).Drive.Name
    }     
    
    Write-Host "Debug: Set ENV:Drive to $Drive" -ForegroundColor Green
}    
