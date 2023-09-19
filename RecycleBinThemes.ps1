# Created by Siddharth Dushantha
# https://github.com/sdushantha/recycle-bin-themes
# Edited by TechnoLuc

# Define the version of the script
$version = "v3.0.0"

# This is where we will store the icons
$recycle_bin_themes_path = "$env:userprofile\Pictures\RecycleBinThemes"

# Hide the progressbar from Invoke-WebRequest
$ProgressPreference = "SilentlyContinue"

# Fetch the folder names (theme names) dynamically from the GitHub repository
$github_repo_url = "https://api.github.com/repos/technoluc/recycle-bin-themes/contents/themes"
$github_repo_contents = Invoke-RestMethod -Uri $github_repo_url -Headers @{ "User-Agent" = "PowerShell" }
$supported_themes = $github_repo_contents | Where-Object { $_.type -eq "dir" } | ForEach-Object { $_.name }

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
for ($index = 0; $index -lt $supported_themes.count; $index++) {
  $theme_name = $textInfo.ToTitleCase($($supported_themes[$index])).replace("-", " ")
  Write-Host " [$($index+1)] $theme_name" -ForegroundColor Magenta
}
Write-Host " [0] Default" -ForegroundColor Magenta

# Prompt user for their choice
$choice = $(Write-Host "`nChoice: " -ForegroundColor Yellow -NoNewLine; Read-Host)

# Validate the user's choice
if (-not($choice -ge 0 -and $choice -le $supported_themes.count)) {
  Write-Host "Error: '$choice' is an invalid choice"
  exit 
}

# Function to write to the DefaultIcon registry key
function writeToDefaultIconRegistry {
  param (
    $name,
    $value 
  )
  Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "$name" -Value "$value"
}

# Handle the case when the user chooses the default theme
if ($choice -eq 0) {
  writeToDefaultIconRegistry "(Default)" "%SystemRoot%\System32\imageres.dll,-55"
  writeToDefaultIconRegistry "full" "%SystemRoot%\System32\imageres.dll,-54"
  writeToDefaultIconRegistry "empty" "%SystemRoot%\System32\imageres.dll,-55"

  # Reload the Windows Explorer
  Stop-Process -ProcessName explorer -Force
  Write-Host "Changed Recycle Bin theme back to default" -ForegroundColor Green
  exit
}

# Retrieve the selected theme's icon URLs
$selected_theme = $supported_themes[$choice - 1]
$empty_icon_url = "https://raw.githubusercontent.com/technoluc/recycle-bin-themes/main/themes/$selected_theme/$selected_theme-empty.ico"
$full_icon_url = "https://raw.githubusercontent.com/technoluc/recycle-bin-themes/main/themes/$selected_theme/$selected_theme-full.ico"

# Extract file names from the URLs
$empty_icon_file_name = $empty_icon_url.Split("/")[-1]
$full_icon_file_name = $full_icon_url.Split("/")[-1]

# Construct full file paths for the icons
$empty_icon_path = "$recycle_bin_themes_path\$empty_icon_file_name"
$full_icon_path = "$recycle_bin_themes_path\$full_icon_file_name"

# Create the directory if it doesn't exist
mkdir -Force $recycle_bin_themes_path | Out-Null

# Download the icons if they don't exist locally
if (-not(Test-Path -Path $empty_icon_path -PathType Leaf)) {
  Invoke-WebRequest $empty_icon_url -OutFile $empty_icon_path 
}

if (-not(Test-Path -Path $full_icon_path -PathType Leaf)) {
  Invoke-WebRequest $full_icon_url -OutFile $full_icon_path 
}

# Modify the Windows Registry to use the chosen icons for the Recycle Bin
writeToDefaultIconRegistry "(Default)" "$empty_icon_path,0"
writeToDefaultIconRegistry "full" "$full_icon_path,0"
writeToDefaultIconRegistry "empty" "$empty_icon_path,0"

# Reload the Windows Explorer
Stop-Process -ProcessName explorer -Force

# Display a success message
Write-Host "Changed Recycle Bin theme to $($textInfo.ToTitleCase($selected_theme).replace("-", " "))" -ForegroundColor Green
