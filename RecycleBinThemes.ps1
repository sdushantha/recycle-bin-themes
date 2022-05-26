# Created by Siddharth Dushantha
# https://github.com/sdushantha/recycle-bin-themes
#

$version = "v1.0.1"
# This is where we will store the icons
$recycle_bin_themes_path = "$env:userprofile\Pictures\RecycleBinThemes"
# Hide the progressbar from Invoke-WebRequest
$ProgressPreference = "SilentlyContinue"
$supported_themes = @("patrick-star", "pop-cat", "kirby", "kanna", "sword-kirby", "french-fries", "minecraft-chest")

Write-Host @"
  ___                _       ___ _        _____ _                     
 | _ \___ __ _  _ __| |___  | _ |_)_ _   |_   _| |_  ___ _ __  ___ ___
 |   / -_) _| || / _| / -_) | _ \ | ' \    | | | ' \/ -_) '  \/ -_|_-<
 |_|_\___\__|\_, \__|_\___| |___/_|_||_|   |_| |_||_\___|_|_|_\___/__/
             |__/ $version by Siddharth Dushantha

"@

$textInfo = (Get-Culture).TextInfo
Write-Host "Select a theme:"
for ($index = 0; $index -lt $supported_themes.count; $index++){
    $theme_name = $textInfo.ToTitleCase($($supported_themes[$index])).replace("-", " ")
    Write-Host " [$($index+1)] $theme_name"
}
Write-Host " [0] Default"

$choice = Read-Host "`nChoice"
if (-not($choice -ge 0 -and $choice -le $supported_themes.count)) {
   Write-Host "Error: '$choice' is an invalid choice"
   exit 
}

# This function prevents us from rewriting the tremendously long command each time
function writeToDefaultIconRegistry{
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


$selected_theme = $supported_themes[$choice-1]

$empty_icon_url = "https://raw.githubusercontent.com/sdushantha/recycle-bin-themes/main/themes/$selected_theme/$selected_theme-empty.ico"
$full_icon_url = "https://raw.githubusercontent.com/sdushantha/recycle-bin-themes/main/themes/$selected_theme/$selected_theme-full.ico"

$empty_icon_file_name= $empty_icon_url.Split("/")[-1]
$full_icon_file_name= $full_icon_url.Split("/")[-1]

$empty_icon_path = "$recycle_bin_themes_path\$empty_icon_file_name"
$full_icon_path = "$recycle_bin_themes_path\$full_icon_file_name"

mkdir -Force $recycle_bin_themes_path | Out-Null

if (-not(Test-Path -Path $empty_icon_path -PathType Leaf)) {
  Invoke-WebRequest $empty_icon_url -OutFile $empty_icon_path 
}

if (-not(Test-Path -Path $full_icon_path -PathType Leaf)) {
  Invoke-WebRequest $full_icon_url -OutFile $full_icon_path 
}

# Modify the Registry to use the chosen icons for the Recycle Bin
writeToDefaultIconRegistry "(Default)" "$empty_icon_path,0"
writeToDefaultIconRegistry "full" "$full_icon_path,0"
writeToDefaultIconRegistry "empty" "$empty_icon_path,0"

# Reload Explorer
Stop-Process -ProcessName explorer -Force

Write-Host "Changed Recycle Bin theme to $($textInfo.ToTitleCase($selected_theme).replace("-", " "))"