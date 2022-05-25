# Created by Siddharth Dushantha
# https://github.com/sdushantha/recycle-bin-themes
# Forked by TechnoLuc
#

$version = "v1.1.0"
#$pictures_path = [Environment]::GetFolderPath("MyPictures")
# This is where we will store the icons
$recycle_bin_themes_path = "$env:userprofile\Pictures\RecycleBinThemes"
# Hide the progressbar from Invoke-WebRequest
$ProgressPreference = "SilentlyContinue"
$supported_themes = @("pop-cat", "dachshund", "patrick-star", "kirby", "sword-kirby", "minecraft-chest", "bulbasaul")

Write-Host @"
  ___                _       ___ _        _____ _                     
 | _ \___ __ _  _ __| |___  | _ |_)_ _   |_   _| |_  ___ _ __  ___ ___
 |   / -_) _| || / _| / -_) | _ \ | ' \    | | | ' \/ -_) '  \/ -_|_-<
 |_|_\___\__|\_, \__|_\___| |___/_|_||_|   |_| |_||_\___|_|_|_\___/__/
             |__/ $version by TechnoLuc

"@ -ForegroundColor Magenta

$textInfo = (Get-Culture).TextInfo
Write-Host "Select a theme:" -ForegroundColor Magenta
for ($index = 0; $index -lt $supported_themes.count; $index++) {
  $theme_name = $textInfo.ToTitleCase($($supported_themes[$index])).replace("-", " ")
  Write-Host " [$($index+1)] $theme_name" -ForegroundColor Magenta
}
Write-Host " [0] Default" -ForegroundColor Magenta

$choice = Read-Host "`nChoice"
if (-not($choice -ge 0 -and $choice -le $supported_themes.count)) {
  Write-Host "Error: '$choice' is an invalid choice"
  exit 
}

# This function prevents us from rewriting the tremendously long command each time
function writeToDefaultIconRegistry {
  param (
    $name,
    $value 
  )
  Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "$name" -Value "$value"
}

if ($choice -eq 0) {
  writeToDefaultIconRegistry "(Default)" "%SystemRoot%\System32\imageres.dll,-55"
  writeToDefaultIconRegistry "full" "%SystemRoot%\System32\imageres.dll,-54"
  writeToDefaultIconRegistry "empty" "%SystemRoot%\System32\imageres.dll,-55"

  # Reload Explorer
  Stop-Process -ProcessName explorer -Force
  Write-Host "Changed Recycle Bin theme back to default"
  exit
}


$selected_theme = $supported_themes[$choice - 1]

$empty_icon_url = "https://raw.githubusercontent.com/technoluc/recycle-bin-themes/main/themes/$selected_theme/$selected_theme-empty.ico"
$full_icon_url = "https://raw.githubusercontent.com/technoluc/recycle-bin-themes/main/themes/$selected_theme/$selected_theme-full.ico"

$empty_icon_file_name = $empty_icon_url.Split("/")[-1]
$full_icon_file_name = $full_icon_url.Split("/")[-1]

$empty_icon_path = "$recycle_bin_themes_path\$empty_icon_file_name"
$full_icon_path = "$recycle_bin_themes_path\$full_icon_file_name"

mkdir -Force $recycle_bin_themes_path | Out-Null

Invoke-WebRequest $empty_icon_url -OutFile $empty_icon_path 

Invoke-WebRequest $full_icon_url -OutFile $full_icon_path 

# Modify the Registry to use the chosen icons for the Recycle Bin
writeToDefaultIconRegistry "(Default)" "$empty_icon_path,0"
writeToDefaultIconRegistry "full" "$full_icon_path,0"
writeToDefaultIconRegistry "empty" "$empty_icon_path,0"

# Reload Explorer
Stop-Process -ProcessName explorer -Force

Write-Host "Changed Recycle Bin theme to $($textInfo.ToTitleCase($selected_theme).replace("-", " "))"