<#
.SYNOPSIS
Changes the Recycle Bin icon theme on Windows.

.DESCRIPTION
This script allows you to change the Recycle Bin icon theme on Windows.
It fetches themes from a GitHub repository and sets the chosen theme as the Recycle Bin icon.

.NOTES
File Name      : Change-RecycleBinTheme.ps1
Author         : Siddharth Dushantha
GitHub Repo    : https://github.com/sdushantha/recycle-bin-themes
Edited by      : TechnoLuc
Version        : 3.0.0
#>

param (
    [string]$recycleBinThemesPath = "$env:userprofile\Pictures\RecycleBinThemes"
)

# Hide the progress bar from Invoke-WebRequest
$ProgressPreference = "SilentlyContinue"

# Fetch the folder names (theme names) dynamically from the GitHub repository
$githubRepoUrl = "https://api.github.com/repos/technoluc/recycle-bin-themes/contents/themes"
$githubRepoContents = Invoke-RestMethod -Uri $githubRepoUrl -Headers @{ "User-Agent" = "PowerShell" }
$supportedThemes = $githubRepoContents | Where-Object { $_.type -eq "dir" } | ForEach-Object { $_.name }

# Display a colorful header with script information
Write-Host @"
  ___                _       ___ _        _____ _                     
 | _ \___ __ _  _ __| |___  | _ |_)_ _   |_   _| |_  ___ _ __  ___ ___
 |   / -_) _| || / _| / -_) | _ \ | ' \    | | | ' \/ -_) '  \/ -_|_-<
 |_|_\___\__|\_, \__|_\___| |___/_|_||_|   |_| |_||_\___|_|_|_\___/__/
             |__/ $version by TechnoLuc

"@ -ForegroundColor Magenta

# Prepare to capitalize theme names for display
$textInfo = (Get-Culture).TextInfo

# Display available theme options
Write-Host "Select a theme:" -ForegroundColor Yellow
for ($index = 0; $index -lt $supportedThemes.Count; $index++) {
    $themeName = $textInfo.ToTitleCase($supportedThemes[$index]).Replace("-", " ")
    Write-Host " [$($index+1)] $themeName" -ForegroundColor Magenta
}
Write-Host " [0] Default" -ForegroundColor Magenta

# Prompt user for their choice
$choice = $(Write-Host "`nChoice: " -ForegroundColor Yellow -NoNewLine; Read-Host)

# Validate the user's choice
if (-not ($choice -ge 0 -and $choice -le $supportedThemes.Count)) {
    Write-Host "Error: '$choice' is an invalid choice"
    exit
}

# Function to write to the DefaultIcon registry key
function WriteToDefaultIconRegistry {
    param (
        [string]$name,
        [string]$value
    )
    Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "$name" -Value "$value"
}

# Handle the case when the user chooses the default theme
if ($choice -eq 0) {
    WriteToDefaultIconRegistry "(Default)" "%SystemRoot%\System32\imageres.dll,-55"
    WriteToDefaultIconRegistry "full" "%SystemRoot%\System32\imageres.dll,-54"
    WriteToDefaultIconRegistry "empty" "%SystemRoot%\System32\imageres.dll,-55"

    # Reload the Windows Explorer
    Stop-Process -Name explorer -Force
    Write-Host "Changed Recycle Bin theme back to default" -ForegroundColor Green
    exit
}

# Retrieve the selected theme's icon URLs
$selectedTheme = $supportedThemes[$choice - 1]
$themeFolderUrl = "https://raw.githubusercontent.com/technoluc/recycle-bin-themes/main/themes/$selectedTheme"
$emptyIconUrl = "$themeFolderUrl/$selectedTheme-empty.ico"
$fullIconUrl = "$themeFolderUrl/$selectedTheme-full.ico"

# Construct full file paths for the icons
$emptyIconPath = Join-Path -Path $recycleBinThemesPath -ChildPath "$selectedTheme-empty.ico"
$fullIconPath = Join-Path -Path $recycleBinThemesPath -ChildPath "$selectedTheme-full.ico"

# Create the directory if it doesn't exist
if (-not (Test-Path -Path $recycleBinThemesPath -PathType Container)) {
    New-Item -Path $recycleBinThemesPath -ItemType Directory | Out-Null
}

# Download the icons if they don't exist locally
foreach ($iconUrl in $emptyIconUrl, $fullIconUrl) {
    $iconFileName = $iconUrl.Split("/")[-1]
    $iconFilePath = Join-Path -Path $recycleBinThemesPath -ChildPath $iconFileName

    if (-not (Test-Path -Path $iconFilePath -PathType Leaf)) {
        Invoke-WebRequest -Uri $iconUrl -OutFile $iconFilePath
    }
}

# Modify the Windows Registry to use the chosen icons for the Recycle Bin
WriteToDefaultIconRegistry "(Default)" "$emptyIconPath,0"
WriteToDefaultIconRegistry "full" "$fullIconPath,0"
WriteToDefaultIconRegistry "empty" "$emptyIconPath,0"

# Reload the Windows Explorer
Stop-Process -Name explorer -Force

# Display a success message
Write-Host "Changed Recycle Bin theme to $($textInfo.ToTitleCase($selectedTheme).Replace("-", " "))" -ForegroundColor Green
