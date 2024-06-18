# Setting the STARSHIP_CONFIG environment variable to the specified path.
# Specifying the STARSHIP_DISTRO to the hostname of the system.

$ENV:STARSHIP_CONFIG = "H:\Users\NRevi\Powershell\Starship\.config\starship.toml"

$ENV:STARSHIP_DISTRO = "[$hostname]"

# Initializing Starship with the PowerShell shell.

Invoke-Expression (& 'C:\Program Files\starship\bin\starship.exe' init powershell --print-full-init | Out-String)

# Defining a function for Scoop.

function scoop {
    if ($args[0] -eq "search") {
        scoop-search-multisource.exe @($args | Select-Object -Skip 1)
    } else {
        scoop.ps1 @args
    }
}

# Initializing Conda environment.

$Env:CONDA_EXE = "C:\ProgramData\miniconda3\Scripts\conda.exe"
$Env:_CE_M = ""
$Env:_CE_CONDA = ""
$Env:_CONDA_ROOT = "C:\ProgramData\miniconda3"
$Env:_CONDA_EXE = "C:\ProgramData\miniconda3\Scripts\conda.exe"

$CondaModuleArgs = @{ChangePs1 = $True}
Import-Module "$Env:_CONDA_ROOT\shell\condabin\Conda.psm1" -ArgumentList $CondaModuleArgs

conda activate base

Remove-Variable CondaModuleArgs

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


#####################################################################################################################################################

# # Setting the STARSHIP_CONFIG environment variable to the specified path.
# # Comment: The alternate path using $HOME may be more portable across different systems. 
# $ENV:STARSHIP_CONFIG = "H:\Users\NRevi\.config\starship.toml"

# # Specifying the STARSHIP_DISTRO to the hostname of the system.
# $ENV:STARSHIP_DISTRO = "[$hostname]"

# # # Initializing Starship with the PowerShell shell.
# # Invoke-Expression (&starship init powershell)
# # Invoke-Expression (& 'C:\Program Files\starship\bin\starship.exe' init powershell)

# # # Setting various environment variables related to development tools.
# # # Comment: Make sure these paths are correct and the tools are installed at these locations.
# # $ENV:Source = "H:\Users\NRevi\.cargo\bin"     # Rust
# # $ENV:ANDROID_NDK = "H:\Users\NRevi\AppData\Local\Android\Sdk\ndk\26.1.10909125\"  # Android NDK toolchain
# # $ENV:TVM_NDK_CC = "H:\Users\NRevi\AppData\Local\Android\Sdk\ndk\26.1.10909125\toolchains\llvm\prebuilt\windows-x86_64\bin\aarch64-linux-android24-clang"  # Android NDK clang
# # $ENV:JAVA_HOME = "C:\Program Files (x86)\Java\jre-1.8"    # Java
# # $ENV:TVM_HOME = "H:\Users\NRevi\.ai\mlc-llm\3rdparty\tvm"     # TVM Unity runtime

# # A function to debug and log for datree.
# function __datree_debug {
#     if ($env:BASH_COMP_DEBUG_FILE) {
#         "$args" | Out-File -Append -FilePath "$env:BASH_COMP_DEBUG_FILE"
#     }
# }

# # Filtering function to escape special characters in strings.
# filter __datree_escapeStringWithSpecialChars {
#     $_ -replace '\s|#|@|\$|;|,|''|\{|\}|\(|\)|"|`|\||<|>|&', '`$&'
# }

# # # Registering argument completer for 'datree' command.
# Register-ArgumentCompleter -CommandName 'datree' -ScriptBlock {
#     # Implement your argument completer logic here.
# }

# # Setting a key handler for F7 to show command history in a GUI grid view.
# # Comment: Ensure the logic inside the script block is correctly implemented based on your requirements.
# Set-PSReadLineKeyHandler -Key F7 -BriefDescription History -LongDescription 'Show command history' -ScriptBlock {
#     # Logic for showing command history in a grid view.
#     $pattern = $null
#     [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$pattern, [ref]$null)
#     if ($pattern) {
#         $pattern = [regex]::Escape($pattern)
#     }

#     $history = [System.Collections.ArrayList]@(
#         # Content of the history array list
#     )
#     $history.Reverse()

#     $command = $history | Out-GridView -Title History -PassThru
#     if ($command) {
#         [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
#         [Microsoft.PowerShell.PSConsoleReadLine]::Insert(($command -join "`n"))
#     }
# }

# # The alias section of your script and other functions

# # Defining various aliases and functions for ease of use in PowerShell.
# # Comment: Ensure that the function names and aliases do not conflict with existing ones.

# function mkdir { New-Item "$args" -ItemType Directory } 
# function GoAdmin { Start-Process pwsh –Verb RunAs }
# function touch { New-Item "$args" -ItemType File }
# function venv { .venv/scripts/activate.ps1 }
# function home { cd c:\Users\NRevia05 }
# function ipall { ipconfig /all }
# function gccc { git clone $args }
# function gitclone { git clone $args }
# function reload_alias { & $PROFILE }
# function profile_alias { editor $PROFILE }

# # Setting aliases for ease of use in PowerShell.
# set-alias -Name ~ -Value home

# set-alias -Name ip -Value ipall

# set-alias -Name dc -Value docker-compose

# set-alias -Name dig -Value nslookup

# set-alias -Name gcc -Value gitclone

# set-alias -Name gccc -Value gccc

# set-alias -Name va -Value venv

# Set-Alias -Name editor -Value code

# Set-Alias -Name edit -Value editor

# Set-Alias -Name profile -Value profile_alias

# Set-Alias -Name reload -Value reload_alias

# Set-Alias 'sudo' 'gsudo'


# # Importing and setting up various modules and utilities.
# Import-Module "gsudoModule"
# # Set-Alias Prompt gsudoPrompt
# Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1

# Import-Module 'gsudoModule.psd1'

# # Setting a key handler for Alt+a to cycle through arguments on the command line.
# # Comment: Ensure the script block logic correctly handles the expected behavior.
# # Cycle through arguments on current line and select the text. This makes it easier to quickly change the argument if re-running a previously run command from the history
# # or if using a psreadline predictor. You can also use a digit argument to specify which argument you want to select, i.e. Alt+1, Alt+a selects the first argument
# # on the command line. 
# Set-PSReadLineKeyHandler -Key Alt+a `
#     -BriefDescription SelectCommandArguments `
#     -LongDescription "Set current selection to next command argument in the command line. Use of digit argument selects argument by position" `
#     -ScriptBlock {
#     # Logic to handle cycling through command line arguments.
#     param($key, $arg)

#     $ast = $null
#     $cursor = $null
#     [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$ast, [ref]$null, [ref]$null, [ref]$cursor)
    
#     $asts = $ast.FindAll( {
#             $args[0] -is [System.Management.Automation.Language.ExpressionAst] -and
#             $args[0].Parent -is [System.Management.Automation.Language.CommandAst] -and
#             $args[0].Extent.StartOffset -ne $args[0].Parent.Extent.StartOffset
#         }, $true)
    
#     if ($asts.Count -eq 0) {
#         [Microsoft.PowerShell.PSConsoleReadLine]::Ding()
#         return
#     }
    
#     $nextAst = $null

#     if ($null -ne $arg) {
#         $nextAst = $asts[$arg - 1]
#     }
#     else {
#         foreach ($ast in $asts) {
#             if ($ast.Extent.StartOffset -ge $cursor) {
#                 $nextAst = $ast
#                 break
#             }
#         } 
        
#         if ($null -eq $nextAst) {
#             $nextAst = $asts[0]
#         }
#     }

#     $startOffsetAdjustment = 0
#     $endOffsetAdjustment = 0

#     if ($nextAst -is [System.Management.Automation.Language.StringConstantExpressionAst] -and
#         $nextAst.StringConstantType -ne [System.Management.Automation.Language.StringConstantType]::BareWord) {
#         $startOffsetAdjustment = 1
#         $endOffsetAdjustment = 2
#     }
    
#     [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($nextAst.Extent.StartOffset + $startOffsetAdjustment)
#     [Microsoft.PowerShell.PSConsoleReadLine]::SetMark($null, $null)
#     [Microsoft.PowerShell.PSConsoleReadLine]::SelectForwardChar($null, ($nextAst.Extent.EndOffset - $nextAst.Extent.StartOffset) - $endOffsetAdjustment)
# }

# # Setting PSReadLine options for prediction and edit mode.
# Set-PSReadLineOption -PredictionSource History
# Set-PSReadLineOption -PredictionViewStyle ListView
# Set-PSReadLineOption -EditMode Windows

# # Invoke-Expression (&scoop-search --hook)
# Invoke-Expression (&scoop-search-multisource.exe --hook)

# #region conda initialize
# # !! Contents within this block are managed by 'conda init' !!
# (& "C:\ProgramData\miniconda3\Scripts\conda.exe" "shell.powershell" "hook") | Out-String | Invoke-Expression
# #endregion



# Invoke-Expression (&starship init powershell)

# ####################################################################################################

# # oh-my-posh init pwsh --config 'C:\Users\NRevi\AppData\Local\Programs\oh-my-posh\themes\aliens.omp.json' | Invoke-Expression


# # # using namespace System.Management.Automation
# # # using namespace System.Management.Automation.Language
# # function touch {New-Item "$args" -ItemType File}

# ##############################################################################################
# # $ENV:STARSHIP_CONFIG = "H:\Users\NRevi\.config\starship.toml"
# # # $ENV:STARSHIP_CONFIG = "$HOME\.starship\starship.toml"
# # $ENV:STARSHIP_DISTRO = "[$hostname]"
# # Invoke-Expression (&starship init powershell)

# # # powershell completion for datree                               
# # function __datree_debug {
# #     if ($env:BASH_COMP_DEBUG_FILE) {
# #         "$args" | Out-File -Append -FilePath "$env:BASH_COMP_DEBUG_FILE"
# #     }
# # }

# # filter __datree_escapeStringWithSpecialChars {
# #     $_ -replace '\s|#|@|\$|;|,|''|\{|\}|\(|\)|"|`|\||<|>|&','`$&'
# # }

# # Register-ArgumentCompleter -CommandName 'datree' -ScriptBlock {
# #     # Content of your argument completer script block
# # }

# # Set-PSReadLineKeyHandler -Key F7 -BriefDescription History -LongDescription 'Show command history' -ScriptBlock {
# #     $pattern = $null
# #     [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$pattern, [ref]$null)
# #     if ($pattern) {
# #         $pattern = [regex]::Escape($pattern)
# #     }

# #     $history = [System.Collections.ArrayList]@(
# #         # Content of the history array list
# #     )
# #     $history.Reverse()

# #     $command = $history | Out-GridView -Title History -PassThru
# #     if ($command) {
# #         [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
# #         [Microsoft.PowerShell.PSConsoleReadLine]::Insert(($command -join "`n"))
# #     }
# # }

# # # The alias section of your script and other functions
# # function mkdir {New-Item "$args" -ItemType Directory} 
# # function touch {New-Item "$args" -ItemType File}
# # function ipall {ipconfig /all}
# # function home {cd c:\Users\NRevia05}
# # function gitclone {git clone $args }
# # function venv {.venv/scripts/activate.ps1 }
# # function server {docker-compose -f C:\server\SmartServer\smarthome.yml up -d}

# # set-alias -Name ~ -Value home
# # set-alias -Name dcs -Value server
# # set-alias -Name ip -Value ipall
# # set-alias -Name dc -Value docker-compose
# # set-alias -Name dig -Value nslookup
# # set-alias -Name gcc -Value gitclone
# # set-alias -Name va -Value venv

# # function GoAdmin { Start-Process pwsh –Verb RunAs }
# # function gcc {git clone $args }
# # function venv {.venv/scripts/activate.ps1 }



# # # Cycle through arguments on current line and select the text. This makes it easier to quickly change the argument if re-running a previously run command from the history
# # # or if using a psreadline predictor. You can also use a digit argument to specify which argument you want to select, i.e. Alt+1, Alt+a selects the first argument
# # # on the command line. 
# # Set-PSReadLineKeyHandler -Key Alt+a `
# #                          -BriefDescription SelectCommandArguments `
# #                          -LongDescription "Set current selection to next command argument in the command line. Use of digit argument selects argument by position" `
# #                          -ScriptBlock {
# #     param($key, $arg)
  
# #     $ast = $null
# #     $cursor = $null
# #     [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$ast, [ref]$null, [ref]$null, [ref]$cursor)
  
# #     $asts = $ast.FindAll( {
# #         $args[0] -is [System.Management.Automation.Language.ExpressionAst] -and
# #         $args[0].Parent -is [System.Management.Automation.Language.CommandAst] -and
# #         $args[0].Extent.StartOffset -ne $args[0].Parent.Extent.StartOffset
# #       }, $true)
  
# #     if ($asts.Count -eq 0) {
# #         [Microsoft.PowerShell.PSConsoleReadLine]::Ding()
# #         return
# #     }
    
# #     $nextAst = $null

# #     if ($null -ne $arg) {
# #         $nextAst = $asts[$arg - 1]
# #     }
# #     else {
# #         foreach ($ast in $asts) {
# #             if ($ast.Extent.StartOffset -ge $cursor) {
# #                 $nextAst = $ast
# #                 break
# #             }
# #         } 
        
# #         if ($null -eq $nextAst) {
# #             $nextAst = $asts[0]
# #         }
# #     }

# #     $startOffsetAdjustment = 0
# #     $endOffsetAdjustment = 0

# #     if ($nextAst -is [System.Management.Automation.Language.StringConstantExpressionAst] -and
# #         $nextAst.StringConstantType -ne [System.Management.Automation.Language.StringConstantType]::BareWord) {
# #             $startOffsetAdjustment = 1
# #             $endOffsetAdjustment = 2
# #     }
  
# #     [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($nextAst.Extent.StartOffset + $startOffsetAdjustment)
# #     [Microsoft.PowerShell.PSConsoleReadLine]::SetMark($null, $null)
# #     [Microsoft.PowerShell.PSConsoleReadLine]::SelectForwardChar($null, ($nextAst.Extent.EndOffset - $nextAst.Extent.StartOffset) - $endOffsetAdjustment)
# # }


# # Set-PSReadLineOption -PredictionSource History
# # Set-PSReadLineOption -PredictionViewStyle ListView
# # Set-PSReadLineOption -EditMode Windows





# ###################################################################################################

# # $ENV:STARSHIP_CONFIG = "$HOME\.starship\starship.toml"
# # $ENV:STARSHIP_DISTRO = "者 xcad"
# # Invoke-Expression (&starship init powershell)


# # # powershell completion for datree                               -*- shell-script -*-

# # function __datree_debug {
# #     if ($env:BASH_COMP_DEBUG_FILE) {
# #         "$args" | Out-File -Append -FilePath "$env:BASH_COMP_DEBUG_FILE"
# #     }
# # }

# # filter __datree_escapeStringWithSpecialChars {
# #     $_ -replace '\s|#|@|\$|;|,|''|\{|\}|\(|\)|"|`|\||<|>|&','`$&'
# # }

# # Register-ArgumentCompleter -CommandName 'datree' -ScriptBlock {
# #     param(
# #             $WordToComplete,
# #             $CommandAst,
# #             $CursorPosition
# #         )

# #     # Get the current command line and convert into a string
# #     $Command = $CommandAst.CommandElements
# #     $Command = "$Command"

# #     __datree_debug ""
# #     __datree_debug "========= starting completion logic =========="
# #     __datree_debug "WordToComplete: $WordToComplete Command: $Command CursorPosition: $CursorPosition"

# #     # The user could have moved the cursor backwards on the command-line.
# #     # We need to trigger completion from the $CursorPosition location, so we need
# #     # to truncate the command-line ($Command) up to the $CursorPosition location.
# #     # Make sure the $Command is longer then the $CursorPosition before we truncate.
# #     # This happens because the $Command does not include the last space.
# #     if ($Command.Length -gt $CursorPosition) {
# #         $Command=$Command.Substring(0,$CursorPosition)
# #     }
# #         __datree_debug "Truncated command: $Command"

# #     $ShellCompDirectiveError=1
# #     $ShellCompDirectiveNoSpace=2
# #     $ShellCompDirectiveNoFileComp=4
# #     $ShellCompDirectiveFilterFileExt=8
# #     $ShellCompDirectiveFilterDirs=16

# #         # Prepare the command to request completions for the program.
# #     # Split the command at the first space to separate the program and arguments.
# #     $Program,$Arguments = $Command.Split(" ",2)
# #     $RequestComp="$Program __complete $Arguments"
# #     __datree_debug "RequestComp: $RequestComp"

# #     # we cannot use $WordToComplete because it
# #     # has the wrong values if the cursor was moved
# #     # so use the last argument
# #     if ($WordToComplete -ne "" ) {
# #         $WordToComplete = $Arguments.Split(" ")[-1]
# #     }
# #     __datree_debug "New WordToComplete: $WordToComplete"


# #     # Check for flag with equal sign
# #     $IsEqualFlag = ($WordToComplete -Like "--*=*" )
# #     if ( $IsEqualFlag ) {
# #         __datree_debug "Completing equal sign flag"
# #         # Remove the flag part
# #         $Flag,$WordToComplete = $WordToComplete.Split("=",2)
# #     }

# #     if ( $WordToComplete -eq "" -And ( -Not $IsEqualFlag )) {
# #         # If the last parameter is complete (there is a space following it)
# #         # We add an extra empty parameter so we can indicate this to the go method.
# #         __datree_debug "Adding extra empty parameter"
# #         # We need to use `"`" to pass an empty argument a "" or '' does not work!!!
# #         $RequestComp="$RequestComp" + ' `"`"'
# #     }

# #     __datree_debug "Calling $RequestComp"
# #     #call the command store the output in $out and redirect stderr and stdout to null
# #     # $Out is an array contains each line per element
# #     Invoke-Expression -OutVariable out "$RequestComp" 2>&1 | Out-Null


# #     # get directive from last line
# #     [int]$Directive = $Out[-1].TrimStart(':')
# #     if ($Directive -eq "") {
# #         # There is no directive specified
# #         $Directive = 0
# #     }
# #     __datree_debug "The completion directive is: $Directive"

# #     # remove directive (last element) from out
# #     $Out = $Out | Where-Object { $_ -ne $Out[-1] }
# #     __datree_debug "The completions are: $Out"

# #     if (($Directive -band $ShellCompDirectiveError) -ne 0 ) {
# #         # Error code.  No completion.
# #         __datree_debug "Received error from custom completion go code"
# #         return
# #     }

# #     $Longest = 0
# #     $Values = $Out | ForEach-Object {
# #         #Split the output in name and description
# #         $Name, $Description = $_.Split("`t",2)
# #         __datree_debug "Name: $Name Description: $Description"

# #         # Look for the longest completion so that we can format things nicely
# #         if ($Longest -lt $Name.Length) {
# #             $Longest = $Name.Length
# #         }

# #         # Set the description to a one space string if there is none set.
# #         # This is needed because the CompletionResult does not accept an empty string as argument
# #         if (-Not $Description) {
# #             $Description = " "
# #         }
# #         @{Name="$Name";Description="$Description"}
# #     }


# #     $Space = " "
# #     if (($Directive -band $ShellCompDirectiveNoSpace) -ne 0 ) {
# #         # remove the space here
# #         __datree_debug "ShellCompDirectiveNoSpace is called"
# #         $Space = ""
# #     }

# #     if (($Directive -band $ShellCompDirectiveNoFileComp) -ne 0 ) {
# #         __datree_debug "ShellCompDirectiveNoFileComp is called"

# #         if ($Values.Length -eq 0) {
# #             # Just print an empty string here so the
# #             # shell does not start to complete paths.
# #             # We cannot use CompletionResult here because
# #             # it does not accept an empty string as argument.
# #             ""
# #             return
# #         }
# #     }

# #     if ((($Directive -band $ShellCompDirectiveFilterFileExt) -ne 0 ) -or
# #        (($Directive -band $ShellCompDirectiveFilterDirs) -ne 0 ))  {
# #         __datree_debug "ShellCompDirectiveFilterFileExt ShellCompDirectiveFilterDirs are not supported"

# #         # return here to prevent the completion of the extensions
# #         return
# #     }

# #     $Values = $Values | Where-Object {
# #         # filter the result
# #         $_.Name -like "$WordToComplete*"

# #         # Join the flag back if we have a equal sign flag
# #         if ( $IsEqualFlag ) {
# #             __datree_debug "Join the equal sign flag back to the completion value"
# #             $_.Name = $Flag + "=" + $_.Name
# #         }
# #     }

# #     # Get the current mode
# #     $Mode = (Get-PSReadLineKeyHandler | Where-Object {$_.Key -eq "Tab" }).Function
# #     __datree_debug "Mode: $Mode"

# #     $Values | ForEach-Object {

# #         # store temporay because switch will overwrite $_
# #         $comp = $_

# #         # PowerShell supports three different completion modes
# #         # - TabCompleteNext (default windows style - on each key press the next option is displayed)
# #         # - Complete (works like bash)
# #         # - MenuComplete (works like zsh)
# #         # You set the mode with Set-PSReadLineKeyHandler -Key Tab -Function <mode>

# #         # CompletionResult Arguments:
# #         # 1) CompletionText text to be used as the auto completion result
# #         # 2) ListItemText   text to be displayed in the suggestion list
# #         # 3) ResultType     type of completion result
# #         # 4) ToolTip        text for the tooltip with details about the object

# #         # Set the options for Tab completion
# #         Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete


# #         switch ($Mode) {

# #             # bash like
# #             "Complete" {

# #                 if ($Values.Length -eq 1) {
# #                     __datree_debug "Only one completion left"

# #                     # insert space after value
# #                     [System.Management.Automation.CompletionResult]::new($($comp.Name | __datree_escapeStringWithSpecialChars) + $Space, "$($comp.Name)", 'ParameterValue', "$($comp.Description)")

# #                 } else {
# #                     # Add the proper number of spaces to align the descriptions
# #                     while($comp.Name.Length -lt $Longest) {
# #                         $comp.Name = $comp.Name + " "
# #                     }

# #                     # Check for empty description and only add parentheses if needed
# #                     if ($($comp.Description) -eq " " ) {
# #                         $Description = ""
# #                     } else {
# #                         $Description = "  ($($comp.Description))"
# #                     }

# #                     [System.Management.Automation.CompletionResult]::new("$($comp.Name)$Description", "$($comp.Name)$Description", 'ParameterValue', "$($comp.Description)")
# #                 }
# #              }

# #             # zsh like
# #             "MenuComplete" {
# #                 # insert space after value
# #                 # MenuComplete will automatically show the ToolTip of
# #                 # the highlighted value at the bottom of the suggestions.
# #                 [System.Management.Automation.CompletionResult]::new($($comp.Name | __datree_escapeStringWithSpecialChars) + $Space, "$($comp.Name)", 'ParameterValue', "$($comp.Description)")
# #             }

# #             # TabCompleteNext and in case we get something unknown
# #             Default {
# #                 # Like MenuComplete but we don't want to add a space here because
# #                 # the user need to press space anyway to get the completion.
# #                 # Description will not be shown because thats not possible with TabCompleteNext
# #                 [System.Management.Automation.CompletionResult]::new($($comp.Name | __datree_escapeStringWithSpecialChars), "$($comp.Name)", 'ParameterValue', "$($comp.Description)")
# #             }
# #             # This key handler shows the entire or filtered history using Out-GridView. The
# # # typed text is used as the substring pattern for filtering. A selected command
# # # is inserted to the command line without invoking. Multiple command selection
# # # is supported, e.g. selected by Ctrl + Click.

# #     Set-PSReadLineKeyHandler -Key F7`
# #                             -BriefDescription History`
# #                             -LongDescription 'Show command history'`
# #                             -ScriptBlock {
# #     $pattern = $null
# #     [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$pattern, [ref]$null)
# #     if ($pattern) {
# #         $pattern = [regex]::Escape($pattern)
# #     }
# #     $history = [System.Collections.ArrayList]@(
# #         $last = ''
# #         $lines = ''
# #         foreach ($line in [System.IO.File]::ReadLines((Get-PSReadLineOption).HistorySavePath)) {
# #             if ($line.EndsWith('`')) {
# #                 $line = $line.Substring(0, $line.Length - 1)
# #                 $lines = if ($lines) { "$lines`n$line" } else { $line }
# #                 continue
# #             }
# #             if ($lines) {
# #                 $line = "$lines`n$line"
# #                 $lines = ''
# #             }

# #             if (($line -cne $last) -and (!$pattern -or ($line -match $pattern))) {
# #                 $last = $line
# #                 $line
# #             }
# #         }
# #     $history.Reverse()

# #     $command = $history | Out-GridView -Title History -PassThru
# #     if ($command) {
# #         [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
# #         [Microsoft.PowerShell.PSConsoleReadLine]::Insert(($command -join "`n"))
# #     }
# # }
# #         }
# #     }
# # }


# # # Set-PSReadLi/neKeyHandler -Key F7 `
# #                         #  -BriefDescription History `
# # #                          -LongDescription 'Show command history' `
# # #                          -ScriptBlock {
# # #     $pattern = $null
# # #     [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$pattern, [ref]$null)
# # #     if ($pattern)
# # #     {
# # #         $pattern = [regex]::Escape($pattern)
# # #     }

# # #     $history = [System.Collections.ArrayList]@(
# # #         $last = ''
# # #         $lines = ''
# # #         foreach ($line in [System.IO.File]::ReadLines((Get-PSReadLineOption).HistorySavePath))
# # #         {
# # #             if ($line.EndsWith('`'))
# # #             {
# # #                 $line = $line.Substring(0, $line.Length - 1)
# # #                 $lines = if ($lines)
# # #                 {
# # #                     "$lines`n$line"
# # #                 }
# # #                 else
# # #                 {
# # #                     $line
# # #                 }
# # #                 continue
# # #             }

# # #             if ($lines)
# # #             {
# # #                 $line = "$lines`n$line"
# # #                 $lines = ''
# # #             }

# # #             if (($line -cne $last) -and (!$pattern -or ($line -match $pattern)))
# # #             {
# # #                 $last = $line
# # #                 $line
# # #             }
# # #         }
# # #     )
# # #     $history.Reverse()

# # #     $command = $history | Out-GridView -Title History -PassThru
# # #     if ($command)
# # #     {
# # #         [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
# # #         [Microsoft.PowerShell.PSConsoleReadLine]::Insert(($command -join "`n"))
# # #     }
# # # }

# # #         }

# # #     }
# # # }



# # ##########################################################################################################

# # #alias


# # # using namespace System.Management.Automation
# # function mkdir {New-Item "$args" -ItemType Directory} 

# # # using namespace System.Management.Automation.Language
# # function touch {New-Item "$args" -ItemType File}

# # function ipall {ipconfig /all}

# # function smartserver {cd c:\server}

# # function gitclone {git clone $args }

# # function venv {.venv/scripts/activate.ps1 }

# # function server {docker-compose -f C:\server\SmartServer\smarthome.yml up -d}

# # set-alias -Name ss -Value smartserver

# # set-alias -Name dcs -Value server

# # set-alias -Name ip -Value ipall

# # set-alias -Name dc -Value docker-compose

# # set-alias -Name dig -Value nslookup

# # set-alias -Name gcc -Value gitclone

# # set-alias -Name va -Value venv

# # function GoAdmin { Start-Process pwsh –Verb RunAs }

# # function gc {git clone $args }

# # function venv {.venv/scripts/activate.ps1 }


# ############################################################################################################
# # # using namespace System.Management.Automation
# # # using namespace System.Management.Automation.Language




# # # Import-Module go-my-posh
# # Import-Module -Name Terminal-Icons
# # # Import-Module -Name posh-git

# # if ($host.Name -eq 'ConsoleHost')
# # {
# #     Import-Module PSReadLine

# # }

# # #alias


# # # using namespace System.Management.Automation
# # function mkdir {New-Item "$args" -ItemType Directory} 

# # # using namespace System.Management.Automation.Language
# # function touch {New-Item "$args" -ItemType File}

# # function ipall {ipconfig /all}

# # function smartserver {cd c:\server}

# # function gc {git clone $args }

# # function venv {.venv/scripts/activate.ps1 }

# # function server {docker-compose -f C:\server\SmartServer\smarthome.yml up -d}

# # set-alias -Name ss -Value smartserver

# # set-alias -Name dcs -Value server

# # set-alias -Name ip -Value ipall

# # set-alias -Name dc -Value docker-compose

# # set-alias -Name dig -Value nslookup

# # set-alias -Name gcc -Value gitclone

# # set-alias -Name va -Value venv

# # function GoAdmin { Start-Process pwsh –Verb RunAs }

# # # oh-my-posh init pwsh --config 'C:\Users\NRevi\AppData\Local\Programs\oh-my-posh\themes\catppuccin_frappe.omp.json' | Invoke-Expression

# # oh-my-posh init pwsh --config 'C:\Users\NRevi\AppData\Local\Programs\oh-my-posh\themes\catppuccin_latte.omp.json' | Invoke-Expression

# # # oh-my-posh init pwsh --config 'C:\Users\NRevi\AppData\Local\Programs\oh-my-posh\themes\catppuccin_macchiato.omp.json' | Invoke-Expression

# # # oh-my-posh init pwsh --config 'C:\Users\NRevi\AppData\Local\Programs\oh-my-posh\themes\catppuccin_mocha.omp.json' | Invoke-Expression

# # # oh-my-posh init pwsh --config 'C:\Users\NRevi\AppData\Local\Programs\oh-my-posh\themes\clean-detailed.omp.json' | Invoke-Expression
# # # oh-my-posh init pwsh --config 'C:\Users\NRevi\AppData\Local\Programs\oh-my-posh\themes\hul10.omp.json' | Invoke-Expression

# # #oh-my-posh init pwsh --config 'C:\Users\NRevi\AppData\Local\Programs\oh-my-posh\themes\kushal.omp.json' | Invoke-Expression


# # # oh-my-posh init pwsh --config 'C:\Users\NRevi\OneDrive\Documents\PowerShell\themes\grandpa-style.omp.json' | Invoke-Expression
# # # oh-my-posh init pwsh --config 'C:\Users\NRevi\OneDrive\Documents\PowerShell\themes\powerlevel10k_classic.omp.json' | Invoke-Expression
# # # oh-my-posh init pwsh --config 'C:\Users\NRevi\OneDrive\Documents\PowerShell\themes\sonicboom_dark.omp.json' | Invoke-Expression
# # # oh-my-posh init pwsh --config 'C:\Users\NRevi\OneDrive\Documents\PowerShell\themes\bubblesline.omp.json' | Invoke-Expression




# # Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
# #     param($wordToComplete, $commandAst, $cursorPosition)
# #         [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
# #         $Local:word = $wordToComplete.Replace('"', '""')
# #         $Local:ast = $commandAst.ToString().Replace('"', '""')
# #         winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
# #             [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
# #         }
# # }

# # # PowerShell parameter completion shim for the dotnet CLI
# # Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
# #      param($commandName, $wordToComplete, $cursorPosition)
# #          dotnet complete --position $cursorPosition "$wordToComplete" | ForEach-Object {
# #             [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
# #          }
# #  }

# # # ---


# # # This is an example profile for PSReadLine.
# # #
# # # This is roughly what I use so there is some emphasis on emacs bindings,
# # # but most of these bindings make sense in Windows mode as well.

# # # Searching for commands with up/down arrow is really handy.  The
# # # option "moves to end" is useful if you want the cursor at the end
# # # of the line while cycling through history like it does w/o searching,
# # # without that option, the cursor will remain at the position it was
# # # when you used up arrow, which can be useful if you forget the exact
# # # string you started the search on.
# # Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
# # Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# # # This key handler shows the entire or filtered history using Out-GridView. The
# # # typed text is used as the substring pattern for filtering. A selected command
# # # is inserted to the command line without invoking. Multiple command selection
# # # is supported, e.g. selected by Ctrl + Click.
# # Set-PSReadLineKeyHandler -Key F7 `
# #                          -BriefDescription History `
# #                          -LongDescription 'Show command history' `
# #                          -ScriptBlock {
# #     $pattern = $null
# #     [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$pattern, [ref]$null)
# #     if ($pattern)
# #     {
# #         $pattern = [regex]::Escape($pattern)
# #     }

# #     $history = [System.Collections.ArrayList]@(
# #         $last = ''
# #         $lines = ''
# #         foreach ($line in [System.IO.File]::ReadLines((Get-PSReadLineOption).HistorySavePath))
# #         {
# #             if ($line.EndsWith('`'))
# #             {
# #                 $line = $line.Substring(0, $line.Length - 1)
# #                 $lines = if ($lines)
# #                 {
# #                     "$lines`n$line"
# #                 }
# #                 else
# #                 {
# #                     $line
# #                 }
# #                 continue
# #             }

# #             if ($lines)
# #             {
# #                 $line = "$lines`n$line"
# #                 $lines = ''
# #             }

# #             if (($line -cne $last) -and (!$pattern -or ($line -match $pattern)))
# #             {
# #                 $last = $line
# #                 $line
# #             }
# #         }
# #     )
# #     $history.Reverse()

# #     $command = $history | Out-GridView -Title History -PassThru
# #     if ($command)
# #     {
# #         [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
# #         [Microsoft.PowerShell.PSConsoleReadLine]::Insert(($command -join "`n"))
# #     }
# # }


# # # CaptureScreen is good for blog posts or email showing a transaction
# # # of what you did when asking for help or demonstrating a technique.
# # # Set-PSReadLineKeyHandler -Chord 'Ctrl+d,Ctrl+c' -Function CaptureScreen

# # # The built-in word movement uses character delimiters, but token based word
# # # movement is also very useful - these are the bindings you'd use if you
# # # prefer the token based movements bound to the normal emacs word movement
# # # key bindings.

# # #[ Set-PSReadLineKeyHandler -Key Alt+d -Function ShellKillWord
# # # Set-PSReadLineKeyHandler -Key Alt+Backspace -Function ShellBackwardKillWord
# # # Set-PSReadLineKeyHandler -Key Alt+b -Function ShellBackwardWord
# # # Set-PSReadLineKeyHandler -Key Alt+f -Function ShellForwardWord
# # # Set-PSReadLineKeyHandler -Key Alt+B -Function SelectShellBackwardWord
# # # Set-PSReadLineKeyHandler -Key Alt+F -Function SelectShellForwardWord]

# # #region Smart Insert/Delete

# # # The next four key handlers are designed to make entering matched quotes
# # # parens, and braces a nicer experience.  I'd like to include functions
# # # in the module that do this, but this implementation still isn't as smart
# # # as ReSharper, so I'm just providing it as a sample.

# # Set-PSReadLineKeyHandler -Key '"',"'" `
# #                          -BriefDescription SmartInsertQuote `
# #                          -LongDescription "Insert paired quotes if not already on a quote" `
# #                          -ScriptBlock {
# #     param($key, $arg)

# #     $quote = $key.KeyChar

# #     $selectionStart = $null
# #     $selectionLength = $null
# #     [Microsoft.PowerShell.PSConsoleReadLine]::GetSelectionState([ref]$selectionStart, [ref]$selectionLength)

# #     $line = $null
# #     $cursor = $null
# #     [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

# #     # If text is selected, just quote it without any smarts
# #     if ($selectionStart -ne -1)
# #     {
# #         [Microsoft.PowerShell.PSConsoleReadLine]::Replace($selectionStart, $selectionLength, $quote + $line.SubString($selectionStart, $selectionLength) + $quote)
# #         [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($selectionStart + $selectionLength + 2)
# #         return
# #     }

# #     $ast = $null
# #     $tokens = $null
# #     $parseErrors = $null
# #     [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$ast, [ref]$tokens, [ref]$parseErrors, [ref]$null)

# #     function FindToken
# #     {
# #         param($tokens, $cursor)

# #         foreach ($token in $tokens)
# #         {
# #             if ($cursor -lt $token.Extent.StartOffset) { continue }
# #             if ($cursor -lt $token.Extent.EndOffset) {
# #                 $result = $token
# #                 $token = $token -as [StringExpandableToken]
# #                 if ($token) {
# #                     $nested = FindToken $token.NestedTokens $cursor
# #                     if ($nested) { $result = $nested }
# #                 }

# #                 return $result
# #             }
# #         }
# #         return $null
# #     }

# #     $token = FindToken $tokens $cursor

# #     # If we're on or inside a **quoted** string token (so not generic), we need to be smarter
# #     if ($token -is [StringToken] -and $token.Kind -ne [TokenKind]::Generic) {
# #         # If we're at the start of the string, assume we're inserting a new string
# #         if ($token.Extent.StartOffset -eq $cursor) {
# #             [Microsoft.PowerShell.PSConsoleReadLine]::Insert("$quote$quote ")
# #             [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor + 1)
# #             return
# #         }

# #         # If we're at the end of the string, move over the closing quote if present.
# #         if ($token.Extent.EndOffset -eq ($cursor + 1) -and $line[$cursor] -eq $quote) {
# #             [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor + 1)
# #             return
# #         }
# #     }

# #     if ($null -eq $token -or
# #         $token.Kind -eq [TokenKind]::RParen -or $token.Kind -eq [TokenKind]::RCurly -or $token.Kind -eq [TokenKind]::RBracket) {
# #         if ($line[0..$cursor].Where{$_ -eq $quote}.Count % 2 -eq 1) {
# #             # Odd number of quotes before the cursor, insert a single quote
# #             [Microsoft.PowerShell.PSConsoleReadLine]::Insert($quote)
# #         }
# #         else {
# #             # Insert matching quotes, move cursor to be in between the quotes
# #             [Microsoft.PowerShell.PSConsoleReadLine]::Insert("$quote$quote")
# #             [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor + 1)
# #         }
# #         return
# #     }

# #     # If cursor is at the start of a token, enclose it in quotes.
# #     if ($token.Extent.StartOffset -eq $cursor) {
# #         if ($token.Kind -eq [TokenKind]::Generic -or $token.Kind -eq [TokenKind]::Identifier -or 
# #             $token.Kind -eq [TokenKind]::Variable -or $token.TokenFlags.hasFlag([TokenFlags]::Keyword)) {
# #             $end = $token.Extent.EndOffset
# #             $len = $end - $cursor
# #             [Microsoft.PowerShell.PSConsoleReadLine]::Replace($cursor, $len, $quote + $line.SubString($cursor, $len) + $quote)
# #             [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($end + 2)
# #             return
# #         }
# #     }

# #     # We failed to be smart, so just insert a single quote
# #     [Microsoft.PowerShell.PSConsoleReadLine]::Insert($quote)
# # }

# # Set-PSReadLineKeyHandler -Key '(','{','[' `
# #                          -BriefDescription InsertPairedBraces `
# #                          -LongDescription "Insert matching braces" `
# #                          -ScriptBlock {
# #     param($key, $arg)

# #     $closeChar = switch ($key.KeyChar)
# #     {
# #         <#case#> '(' { [char]')'; break }
# #         <#case#> '{' { [char]'}'; break }
# #         <#case#> '[' { [char]']'; break }
# #     }

# #     $selectionStart = $null
# #     $selectionLength = $null
# #     [Microsoft.PowerShell.PSConsoleReadLine]::GetSelectionState([ref]$selectionStart, [ref]$selectionLength)

# #     $line = $null
# #     $cursor = $null
# #     [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
    
# #     if ($selectionStart -ne -1)
# #     {
# #       # Text is selected, wrap it in brackets
# #       [Microsoft.PowerShell.PSConsoleReadLine]::Replace($selectionStart, $selectionLength, $key.KeyChar + $line.SubString($selectionStart, $selectionLength) + $closeChar)
# #       [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($selectionStart + $selectionLength + 2)
# #     } else {
# #       # No text is selected, insert a pair
# #       [Microsoft.PowerShell.PSConsoleReadLine]::Insert("$($key.KeyChar)$closeChar")
# #       [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor + 1)
# #     }
# # }

# # Set-PSReadLineKeyHandler -Key ')',']','}' `
# #                          -BriefDescription SmartCloseBraces `
# #                          -LongDescription "Insert closing brace or skip" `
# #                          -ScriptBlock {
# #     param($key, $arg)

# #     $line = $null
# #     $cursor = $null
# #     [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

# #     if ($line[$cursor] -eq $key.KeyChar)
# #     {
# #         [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor + 1)
# #     }
# #     else
# #     {
# #         [Microsoft.PowerShell.PSConsoleReadLine]::Insert("$($key.KeyChar)")
# #     }
# # }

# # Set-PSReadLineKeyHandler -Key Backspace `
# #                          -BriefDescription SmartBackspace `
# #                          -LongDescription "Delete previous character or matching quotes/parens/braces" `
# #                          -ScriptBlock {
# #     param($key, $arg)

# #     $line = $null
# #     $cursor = $null
# #     [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

# #     if ($cursor -gt 0)
# #     {
# #         $toMatch = $null
# #         if ($cursor -lt $line.Length)
# #         {
# #             switch ($line[$cursor])
# #             {
# #                 <#case#> '"' { $toMatch = '"'; break }
# #                 <#case#> "'" { $toMatch = "'"; break }
# #                 <#case#> ')' { $toMatch = '('; break }
# #                 <#case#> ']' { $toMatch = '['; break }
# #                 <#case#> '}' { $toMatch = '{'; break }
# #             }
# #         }

# #         if ($toMatch -ne $null -and $line[$cursor-1] -eq $toMatch)
# #         {
# #             [Microsoft.PowerShell.PSConsoleReadLine]::Delete($cursor - 1, 2)
# #         }
# #         else
# #         {
# #             [Microsoft.PowerShell.PSConsoleReadLine]::BackwardDeleteChar($key, $arg)
# #         }
# #     }
# # }

# # #endregion Smart Insert/Delete

# # # Sometimes you enter a command but realize you forgot to do something else first.
# # # This binding will let you save that command in the history so you can recall it,
# # # but it doesn't actually execute.  It also clears the line with RevertLine so the
# # # undo stack is reset - though redo will still reconstruct the command line.
# # Set-PSReadLineKeyHandler -Key Alt+w `
# #                          -BriefDescription SaveInHistory `
# #                          -LongDescription "Save current line in history but do not execute" `
# #                          -ScriptBlock {
# #     param($key, $arg)

# #     $line = $null
# #     $cursor = $null
# #     [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
# #     [Microsoft.PowerShell.PSConsoleReadLine]::AddToHistory($line)
# #     [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
# # }

# # # Insert text from the clipboard as a here string
# # Set-PSReadLineKeyHandler -Key Ctrl+V `
# #                          -BriefDescription PasteAsHereString `
# #                          -LongDescription "Paste the clipboard text as a here string" `
# #                          -ScriptBlock {
# #     param($key, $arg)

# #     Add-Type -Assembly PresentationCore
# #     if ([System.Windows.Clipboard]::ContainsText())
# #     {
# #         # Get clipboard text - remove trailing spaces, convert \r\n to \n, and remove the final \n.
# #         $text = ([System.Windows.Clipboard]::GetText() -replace "\p{Zs}*`r?`n","`n").TrimEnd()
# #         [Microsoft.PowerShell.PSConsoleReadLine]::Insert("@'`n$text`n'@")
# #     }
# #     else
# #     {
# #         [Microsoft.PowerShell.PSConsoleReadLine]::Ding()
# #     }
# # }

# # # Sometimes you want to get a property of invoke a member on what you've entered so far
# # # but you need parens to do that.  This binding will help by putting parens around the current selection,
# # # or if nothing is selected, the whole line.
# # Set-PSReadLineKeyHandler -Key 'Alt+(' `
# #                          -BriefDescription ParenthesizeSelection `
# #                          -LongDescription "Put parenthesis around the selection or entire line and move the cursor to after the closing parenthesis" `
# #                          -ScriptBlock {
# #     param($key, $arg)

# #     $selectionStart = $null
# #     $selectionLength = $null
# #     [Microsoft.PowerShell.PSConsoleReadLine]::GetSelectionState([ref]$selectionStart, [ref]$selectionLength)

# #     $line = $null
# #     $cursor = $null
# #     [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
# #     if ($selectionStart -ne -1)
# #     {
# #         [Microsoft.PowerShell.PSConsoleReadLine]::Replace($selectionStart, $selectionLength, '(' + $line.SubString($selectionStart, $selectionLength) + ')')
# #         [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($selectionStart + $selectionLength + 2)
# #     }
# #     else
# #     {
# #         [Microsoft.PowerShell.PSConsoleReadLine]::Replace(0, $line.Length, '(' + $line + ')')
# #         [Microsoft.PowerShell.PSConsoleReadLine]::EndOfLine()
# #     }
# # }

# # # Each time you press Alt+', this key handler will change the token
# # # under or before the cursor.  It will cycle through single quotes, double quotes, or
# # # no quotes each time it is invoked.
# # Set-PSReadLineKeyHandler -Key "Alt+'" `
# #                          -BriefDescription ToggleQuoteArgument `
# #                          -LongDescription "Toggle quotes on the argument under the cursor" `
# #                          -ScriptBlock {
# #     param($key, $arg)

# #     $ast = $null
# #     $tokens = $null
# #     $errors = $null
# #     $cursor = $null
# #     [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$ast, [ref]$tokens, [ref]$errors, [ref]$cursor)

# #     $tokenToChange = $null
# #     foreach ($token in $tokens)
# #     {
# #         $extent = $token.Extent
# #         if ($extent.StartOffset -le $cursor -and $extent.EndOffset -ge $cursor)
# #         {
# #             $tokenToChange = $token

# #             # If the cursor is at the end (it's really 1 past the end) of the previous token,
# #             # we only want to change the previous token if there is no token under the cursor
# #             if ($extent.EndOffset -eq $cursor -and $foreach.MoveNext())
# #             {
# #                 $nextToken = $foreach.Current
# #                 if ($nextToken.Extent.StartOffset -eq $cursor)
# #                 {
# #                     $tokenToChange = $nextToken
# #                 }
# #             }
# #             break
# #         }
# #     }

# #     if ($tokenToChange -ne $null)
# #     {
# #         $extent = $tokenToChange.Extent
# #         $tokenText = $extent.Text
# #         if ($tokenText[0] -eq '"' -and $tokenText[-1] -eq '"')
# #         {
# #             # Switch to no quotes
# #             $replacement = $tokenText.Substring(1, $tokenText.Length - 2)
# #         }
# #         elseif ($tokenText[0] -eq "'" -and $tokenText[-1] -eq "'")
# #         {
# #             # Switch to double quotes
# #             $replacement = '"' + $tokenText.Substring(1, $tokenText.Length - 2) + '"'
# #         }
# #         else
# #         {
# #             # Add single quotes
# #             $replacement = "'" + $tokenText + "'"
# #         }

# #         [Microsoft.PowerShell.PSConsoleReadLine]::Replace(
# #             $extent.StartOffset,
# #             $tokenText.Length,
# #             $replacement)
# #     }
# # }

# # # This example will replace any aliases on the command line with the resolved commands.
# # Set-PSReadLineKeyHandler -Key "Alt+%" `
# #                          -BriefDescription ExpandAliases `
# #                          -LongDescription "Replace all aliases with the full command" `
# #                          -ScriptBlock {
# #     param($key, $arg)

# #     $ast = $null
# #     $tokens = $null
# #     $errors = $null
# #     $cursor = $null
# #     [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$ast, [ref]$tokens, [ref]$errors, [ref]$cursor)

# #     $startAdjustment = 0
# #     foreach ($token in $tokens)
# #     {
# #         if ($token.TokenFlags -band [TokenFlags]::CommandName)
# #         {
# #             $alias = $ExecutionContext.InvokeCommand.GetCommand($token.Extent.Text, 'Alias')
# #             if ($alias -ne $null)
# #             {
# #                 $resolvedCommand = $alias.ResolvedCommandName
# #                 if ($resolvedCommand -ne $null)
# #                 {
# #                     $extent = $token.Extent
# #                     $length = $extent.EndOffset - $extent.StartOffset
# #                     [Microsoft.PowerShell.PSConsoleReadLine]::Replace(
# #                         $extent.StartOffset + $startAdjustment,
# #                         $length,
# #                         $resolvedCommand)

# #                     # Our copy of the tokens won't have been updated, so we need to
# #                     # adjust by the difference in length
# #                     $startAdjustment += ($resolvedCommand.Length - $length)
# #                 }
# #             }
# #         }
# #     }
# # }

# # # F1 for help on the command line - naturally
# # Set-PSReadLineKeyHandler -Key F1 `
# #                          -BriefDescription CommandHelp `
# #                          -LongDescription "Open the help window for the current command" `
# #                          -ScriptBlock {
# #     param($key, $arg)

# #     $ast = $null
# #     $tokens = $null
# #     $errors = $null
# #     $cursor = $null
# #     [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$ast, [ref]$tokens, [ref]$errors, [ref]$cursor)

# #     $commandAst = $ast.FindAll( {
# #         $node = $args[0]
# #         $node -is [CommandAst] -and
# #             $node.Extent.StartOffset -le $cursor -and
# #             $node.Extent.EndOffset -ge $cursor
# #         }, $true) | Select-Object -Last 1

# #     if ($commandAst -ne $null)
# #     {
# #         $commandName = $commandAst.GetCommandName()
# #         if ($commandName -ne $null)
# #         {
# #             $command = $ExecutionContext.InvokeCommand.GetCommand($commandName, 'All')
# #             if ($command -is [AliasInfo])
# #             {
# #                 $commandName = $command.ResolvedCommandName
# #             }

# #             if ($commandName -ne $null)
# #             {
# #                 Get-Help $commandName -ShowWindow
# #             }
# #         }
# #     }
# # }


# # #
# # # Ctrl+Shift+j then type a key to mark the current directory.
# # # Ctrj+j then the same key will change back to that directory without
# # # needing to type cd and won't change the command line.

# # #
# # $global:PSReadLineMarks = @{}

# # Set-PSReadLineKeyHandler -Key Ctrl+J `
# #                          -BriefDescription MarkDirectory `
# #                          -LongDescription "Mark the current directory" `
# #                          -ScriptBlock {
# #     param($key, $arg)

# #     $key = [Console]::ReadKey($true)
# #     $global:PSReadLineMarks[$key.KeyChar] = $pwd
# # }

# # Set-PSReadLineKeyHandler -Key Ctrl+j `
# #                          -BriefDescription JumpDirectory `
# #                          -LongDescription "Goto the marked directory" `
# #                          -ScriptBlock {
# #     param($key, $arg)

# #     $key = [Console]::ReadKey()
# #     $dir = $global:PSReadLineMarks[$key.KeyChar]
# #     if ($dir)
# #     {
# #         cd $dir
# #         [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt()
# #     }
# # }

# # Set-PSReadLineKeyHandler -Key Alt+j `
# #                          -BriefDescription ShowDirectoryMarks `
# #                          -LongDescription "Show the currently marked directories" `
# #                          -ScriptBlock {
# #     param($key, $arg)

# #     $global:PSReadLineMarks.GetEnumerator() | % {
# #         [PSCustomObject]@{Key = $_.Key; Dir = $_.Value} } |
# #         Format-Table -AutoSize | Out-Host

# #     [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt()
# # }

# # # Auto correct 'git cmt' to 'git commit'
# # Set-PSReadLineOption -CommandValidationHandler {
# #     param([CommandAst]$CommandAst)

# #     switch ($CommandAst.GetCommandName())
# #     {
# #         'git' {
# #             $gitCmd = $CommandAst.CommandElements[1].Extent
# #             switch ($gitCmd.Text)
# #             {
# #                 'cmt' {
# #                     [Microsoft.PowerShell.PSConsoleReadLine]::Replace(
# #                         $gitCmd.StartOffset, $gitCmd.EndOffset - $gitCmd.StartOffset, 'commit')
# #                 }
# #             }
# #         }
# #     }
# # }

# # # `ForwardChar` accepts the entire suggestion text when the cursor is at the end of the line.
# # # This custom binding makes `RightArrow` behave similarly - accepting the next word instead of the entire suggestion text.
# # Set-PSReadLineKeyHandler -Key RightArrow `
# #                          -BriefDescription ForwardCharAndAcceptNextSuggestionWord `
# #                          -LongDescription "Move cursor one character to the right in the current editing line and accept the next word in suggestion when it's at the end of current editing line" `
# #                          -ScriptBlock {
# #     param($key, $arg)

# #     $line = $null
# #     $cursor = $null
# #     [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

# #     if ($cursor -lt $line.Length) {
# #         [Microsoft.PowerShell.PSConsoleReadLine]::ForwardChar($key, $arg)
# #     } else {
# #         [Microsoft.PowerShell.PSConsoleReadLine]::AcceptNextSuggestionWord($key, $arg)
# #     }
# # }

# # # Cycle through arguments on current line and select the text. This makes it easier to quickly change the argument if re-running a previously run command from the history
# # # or if using a psreadline predictor. You can also use a digit argument to specify which argument you want to select, i.e. Alt+1, Alt+a selects the first argument
# # # on the command line. 
# # Set-PSReadLineKeyHandler -Key Alt+a `
# #                          -BriefDescription SelectCommandArguments `
# #                          -LongDescription "Set current selection to next command argument in the command line. Use of digit argument selects argument by position" `
# #                          -ScriptBlock {
# #     param($key, $arg)
  
# #     $ast = $null
# #     $cursor = $null
# #     [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$ast, [ref]$null, [ref]$null, [ref]$cursor)
  
# #     $asts = $ast.FindAll( {
# #         $args[0] -is [System.Management.Automation.Language.ExpressionAst] -and
# #         $args[0].Parent -is [System.Management.Automation.Language.CommandAst] -and
# #         $args[0].Extent.StartOffset -ne $args[0].Parent.Extent.StartOffset
# #       }, $true)
  
# #     if ($asts.Count -eq 0) {
# #         [Microsoft.PowerShell.PSConsoleReadLine]::Ding()
# #         return
# #     }
    
# #     $nextAst = $null

# #     if ($null -ne $arg) {
# #         $nextAst = $asts[$arg - 1]
# #     }
# #     else {
# #         foreach ($ast in $asts) {
# #             if ($ast.Extent.StartOffset -ge $cursor) {
# #                 $nextAst = $ast
# #                 break
# #             }
# #         } 
        
# #         if ($null -eq $nextAst) {
# #             $nextAst = $asts[0]
# #         }
# #     }

# #     $startOffsetAdjustment = 0
# #     $endOffsetAdjustment = 0

# #     if ($nextAst -is [System.Management.Automation.Language.StringConstantExpressionAst] -and
# #         $nextAst.StringConstantType -ne [System.Management.Automation.Language.StringConstantType]::BareWord) {
# #             $startOffsetAdjustment = 1
# #             $endOffsetAdjustment = 2
# #     }
  
# #     [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($nextAst.Extent.StartOffset + $startOffsetAdjustment)
# #     [Microsoft.PowerShell.PSConsoleReadLine]::SetMark($null, $null)
# #     [Microsoft.PowerShell.PSConsoleReadLine]::SelectForwardChar($null, ($nextAst.Extent.EndOffset - $nextAst.Extent.StartOffset) - $endOffsetAdjustment)
# # }


# # Set-PSReadLineOption -PredictionSource History
# # Set-PSReadLineOption -PredictionViewStyle ListView
# # Set-PSReadLineOption -EditMode Windows


# # # This is an example of a macro that you might use to execute a command.
# # # This will add the command to history.
# # Set-PSReadLineKeyHandler -Key Ctrl+Shift+b `
# #                          -BriefDescription BuildCurrentDirectory `
# #                          -LongDescription "Build the current directory" `
# #                          -ScriptBlock {
# #     [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
# #     [Microsoft.PowerShell.PSConsoleReadLine]::Insert("dotnet build")
# #     [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
# # }

# # Set-PSReadLineKeyHandler -Key Ctrl+Shift+t `
# #                          -BriefDescription BuildCurrentDirectory `
# #                          -LongDescription "Build the current directory" `
# #                          -ScriptBlock {
# #     [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
# #     [Microsoft.PowerShell.PSConsoleReadLine]::Insert("dotnet test")
# #     [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
# # }
# # # Import the Chocolatey Profile that contains the necessary code to enable
# # # tab-completions to function for `choco`.
# # # Be aware that if you are missing these lines from your profile, tab completion
# # # for `choco` will not function.
# # # See https://ch0.co/tab-completion for details.
# # $ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
# # if (Test-Path($ChocolateyProfile)) {
# #   Import-Module "$ChocolateyProfile"
# # }
# ###################################################################################################