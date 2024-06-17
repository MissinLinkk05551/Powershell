#region Custom Function Definitions

Function Test-Administrator {
    $CurrentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $AdministratorRole = [Security.Principal.WindowsBuiltInRole] "Administrator"
    ([Security.Principal.WindowsPrincipal]$CurrentUser).IsInRole($AdministratorRole)
}

# Function to check and set the drive letter
function Get-DriveL {
        $currentDriveLetter = (Get-Location).Drive.Name
        Write-Host "Debug: Current drive letter is $currentDriveLetter" -ForegroundColor Yellow
    
        $ENV:Drive = "${currentDriveLetter}:"
        Write-Host "Debug: Set ENV:Drive to $ENV:Drive" -ForegroundColor Green
    }


# Override the Set-Location function
function Set-Location {
    param(
        [string]$Path
    )

    # Call the original Set-Location cmdlet
    Microsoft.PowerShell.Management\Set-Location -Path $Path
    
    # Update the drive letter
    Get-DriveL
    Write-Host "Debug: Set ENV:Drive to $Env:Drive" -ForegroundColor Green
}



#region Prompt Prep

# Set ENV for elevated status
If (Test-Administrator) {
    $Env:ISELEVATEDSESSION = 'just needs to be set, never displayed'
}    

if (Get-DriveL) {
    $ENV:DriveL = (Get-Location).Drive.Name
    Write-Host "Debug: Set ENV:drive to $ENV:Drive"
} else {
    Write-Host "Debug: Get-DriveL function is set"
}    



#endregion



