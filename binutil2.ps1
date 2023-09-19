# Created by Siddharth Dushantha
# https://github.com/sdushantha/recycle-bin-themes
# Edited by TechnoLuc
#

param (
    [string]$themeChoice = ""
)

# Definieer de scriptversie en het pad waar de pictogrammen worden opgeslagen
$version = "v2.0.0"
$recycle_bin_themes_path = "$env:userprofile\Pictures\RecycleBinThemes"

# Verberg de voortgangsbalk van Invoke-WebRequest
$ProgressPreference = "SilentlyContinue"

# Ondersteunde thema's voor de prullenbak
$supported_themes = @("pop-cat", "dachshund", "patrick-star", "kirby", "sword-kirby", "minecraft-chest", "french-fries", "bulbasaul")

# Toon een welkomstbericht met de scriptversie
Write-Host @"
  ___                _       ___ _        _____ _                     
 | _ \___ __ _  _ __| |___  | _ |_)_ _   |_   _| |_  ___ _ __  ___ ___
 |   / -_) _| || / _| / -_) | _ \ | ' \    | | | ' \/ -_) '  \/ -_|_-<
 |_|_\___\__|\_, \__|_\___| |___/_|_||_|   |_| |_||_\___|_|_|_\___/__/
             |__/ $version by TechnoLuc

"@ -ForegroundColor Magenta

# Initialisatie van de taalinstellingen
$textInfo = (Get-Culture).TextInfo

if (-not($themeChoice)) {
    # Als geen thema-keuze is opgegeven, vraag de gebruiker om een thema te selecteren
    Write-Host "Select a theme:" -ForegroundColor Yellow
    for ($index = 0; $index -lt $supported_themes.count; $index++) {
        $theme_name = $textInfo.ToTitleCase($($supported_themes[$index])).replace("-", " ")
        Write-Host " [$($index+1)] $theme_name" -ForegroundColor Magenta
    }
    Write-Host " [0] Default" -ForegroundColor Magenta

    # Lees de keuze van de gebruiker
    $choice = $(Write-Host "`nChoice: " -ForegroundColor Yellow -NoNewLine; Read-Host)

    # Controleer of de keuze geldig is
    if (-not($choice -ge 0 -and $choice -le $supported_themes.count)) {
        Write-Host "Error: '$choice' is an invalid choice"
        exit 
    }
}
else {
    # Als een thema-keuze is opgegeven via de parameter, gebruik deze keuze
    $choice = [int]$themeChoice
}

# Functie om het register aan te passen voor pictogrammen
function writeToDefaultIconRegistry {
    param (
        $name,
        $value 
    )
    Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "$name" -Value "$value"
}

if ($choice -eq 0) {
    # Als de keuze 0 is, herstel het standaardthema voor de prullenbak
    writeToDefaultIconRegistry "(Default)" "%SystemRoot%\System32\imageres.dll,-55"
    writeToDefaultIconRegistry "full" "%SystemRoot%\System32\imageres.dll,-54"
    writeToDefaultIconRegistry "empty" "%SystemRoot%\System32\imageres.dll,-55"

    # Herstart Windows Verkenner om de wijzigingen door te voeren
    Stop-Process -ProcessName explorer -Force
    Write-Host "Changed Recycle Bin theme back to default" -ForegroundColor Green
    exit
}

# Bepaal het geselecteerde thema op basis van de keuze van de gebruiker
$selected_theme = $supported_themes[$choice - 1]

# URL's voor de lege en volle prullenbakpictogrammen voor het geselecteerde thema
$empty_icon_url = "https://raw.githubusercontent.com/technoluc/recycle-bin-themes/main/themes/$selected_theme/$selected_theme-empty.ico"
$full_icon_url = "https://raw.githubusercontent.com/technoluc/recycle-bin-themes/main/themes/$selected_theme/$selected_theme-full.ico"

# Bestandsnamen voor de gedownloade pictogrammen
$empty_icon_file_name = $empty_icon_url.Split("/")[-1]
$full_icon_file_name = $full_icon_url.Split("/")[-1]

# Pad naar de gedownloade pictogrambestanden
$empty_icon_path = "$recycle_bin_themes_path\$empty_icon_file_name"
$full_icon_path = "$recycle_bin_themes_path\$full_icon_file_name"

# Maak de map voor pictogrammen als deze niet bestaat
mkdir -Force $recycle_bin_themes_path | Out-Null

# Download de lege prullenbakpictogram als deze niet bestaat
if (-not(Test-Path -Path $empty_icon_path -PathType Leaf)) {
    Invoke-WebRequest $empty_icon_url -OutFile $empty_icon_path 
}

# Download het volle prullenbakpictogram als deze niet bestaat
if (-not(Test-Path -Path $full_icon_path -PathType Leaf)) {
    Invoke-WebRequest $full_icon_url -OutFile $full_icon_path 
}

# Pas het register aan om de gekozen pictogrammen voor de prullenbak te gebruiken
writeToDefaultIconRegistry "(Default)" "$empty_icon_path,0"
writeToDefaultIconRegistry "full" "$full_icon_path,0"
writeToDefaultIconRegistry "empty" "$empty_icon_path,0"

# Herstart Windows Verkenner om de wijzigingen door te voeren
Stop-Process -ProcessName explorer -Force

# Toon een bericht dat het thema is gewijzigd naar het geselecteerde thema
Write-Host "Changed Recycle Bin theme to $($textInfo.ToTitleCase($selected_theme).replace("-", " "))" -ForegroundColor Green
