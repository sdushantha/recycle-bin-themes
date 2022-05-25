##################################################################################################################
# THIS IS A SCRIPT TO AUTOMATE THE PROCESS OF https://github.com/technoluc/recycle-bin-themes                   #
# PLEASE SEE https://www.reddit.com/r/pcmasterrace/comments/uw2se4/i_made_a_patrick_star_version_of_the_cat_bin/ #
##################################################################################################################

# Self-elevate the script if required
<# if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
  if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
    $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
    Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
    Exit
  }
}
#>

# Set the working location to the same location as the script
# Write-Host "Setting Working Directory to Script Root"
# Set-Location $PSScriptRoot

#Get .ico files from github the hard way

#pop-cat-empty.ico
$pcatempty = "https://raw.githubusercontent.com/technoluc/recycle-bin-themes/main/themes/pop-cat/pop-cat-empty.ico"
$pcatemptyoutput = "$env:userprofile\icons\pop-cat-empty.ico"

#pop-cat-full.ico
$pcatfull = "https://raw.githubusercontent.com/technoluc/recycle-bin-themes/main/themes/pop-cat/pop-cat-full.ico"
$pcatfulloutput = "$env:userprofile\icons\pop-cat-full.ico"

#patrick-star-empty
$pstarempty = "https://raw.githubusercontent.com/technoluc/recycle-bin-themes/main/themes/patrick-star/patrick-star-empty.ico"
$pstaremptyoutput = "$env:userprofile\icons\patrick-star-empty.ico"

#patrik-star-full.ico
$pstarfull = "https://raw.githubusercontent.com/technoluc/recycle-bin-themes/main/themes/patrick-star/patrick-star-full.ico"
$pstarfulloutput = "$env:userprofile\icons\patrick-star-full.ico"

#kirby-empty.ico
$kirbyempty = "https://raw.githubusercontent.com/technoluc/recycle-bin-themes/main/themes/kirby/kirby-empty.ico"
$kirbyemptyoutput = "$env:userprofile\icons\kirby-empty.ico"

#kirby-full.ico
$kirbyfull = "https://raw.githubusercontent.com/technoluc/recycle-bin-themes/main/themes/kirby/kirby-full.ico"
$kirbyfulloutput = "$env:userprofile\icons\kirby-full.ico"

#sword-kirby-empty.ico
$skirbyempty = "https://raw.githubusercontent.com/technoluc/recycle-bin-themes/main/themes/sword-kirby/sword-kirby-empty.ico"
$skirbyemptyoutput = "$env:userprofile\icons\skirby-empty.ico"

#sword-kirby-full.ico
$skirbyfull = "https://raw.githubusercontent.com/technoluc/recycle-bin-themes/main/themes/sword-kirby/sword-kirby-full.ico"
$skirbyfulloutput = "$env:userprofile\icons\skirby-full.ico"

#bulbasaul-empty.ico
$bulbasaulempty = "https://raw.githubusercontent.com/technoluc/recycle-bin-themes/main/themes/bulbasaul/bulbasaul-empty.ico"
$bulbasaulemptyoutput = "$env:userprofile\icons\bulbasaul-empty.ico"

#bulbasaul-full.ico
$bulbasaulfull = "https://raw.githubusercontent.com/technoluc/recycle-bin-themes/main/themes/bulbasaul/bulbasaul-full.ico"
$bulbasaulfulloutput = "$env:userprofile\icons\bulbasaul-full.ico"

#minecraft-empty.ico
$minecraftempty = "https://raw.githubusercontent.com/technoluc/recycle-bin-themes/main/themes/minecraft-chest/minecraft-chest-empty.ico"
$minecraftemptyoutput = "$env:userprofile\icons\minecraft-chest-empty.ico"

#minecraft-full.ico
$minecraftfull = "https://raw.githubusercontent.com/technoluc/recycle-bin-themes/main/themes/minecraft-chest/minecraft-chest-full.ico"
$minecraftfulloutput = "$env:userprofile\icons\minecraft-chest-full.ico"

#dachshund-empty.ico
$dachshundempty = "https://raw.githubusercontent.com/technoluc/recycle-bin-themes/main/themes/dachshund/dachshund-empty.ico"
$dachshundemptyoutput = "$env:userprofile\icons\dachshund-empty.ico"

#dachshund-full.ico
$dachshundfull = "https://raw.githubusercontent.com/technoluc/recycle-bin-themes/main/themes/dachshund/dachshund-full.ico"
$dachshundfulloutput = "$env:userprofile\icons\dachshund-full.ico"


#Get user choice
Write-Host "Please choose your theme:"
$choice = $(Write-Host "[1]Pop-Cat `n[2]Patrik Star `n[3]Kirby `n[4]Sword Kirby `n[5]Bulbasaul `n[6]Minecraft Chest `n[7]Dachshund `n[9]Default " -ForegroundColor Yellow) + $(Write-Host "Choice: " -NoNewLine; Read-Host)
if ($choice -eq '1' -or $choice -eq '2' -or $choice -eq '3' -or $choice -eq '4' -or $choice -eq '5' -or $choice -eq '6' -or $choice -eq '7' -or $choice -eq '9') {
  Write-Host "You picked" $choice
}
else {
  Write-Host "You picked" $choice 
  Write-Host "Please enter 1, 2, 3, 4, 5, 6, 7 or 9."
}

if ($choice -eq '1') {

  if (-not(Test-Path -Path $pcatemptyoutput -PathType Leaf)) {
    Write-Host "Downloading pop-cat Empty Icon"
    $url = $pcatempty
    Invoke-WebRequest -Uri $url -OutFile ( New-Item -Path "$pcatemptyoutput" -Force )
  }
  else {
    Write-Host "Pop-cat Empty Icon already exists"
  }

  if (-not(Test-Path -Path $pcatfulloutput -PathType Leaf)) {
    Write-Host "Downloading pop-cat Full Icon"
    $url = $pcatfull
    Invoke-WebRequest -Uri $url -OutFile ( New-Item -Path "$pcatfulloutput" -Force )
  }
  else {
    Write-Host "Pop-cat Full Icon already exists"
  }

  Write-Host "Setting Registry"
  Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "(Default)" -Value "$pcatemptyoutput,0"
  Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "full" -Value "$env:userprofile\icons\pop-cat-full.ico,0"
  Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "empty" -Value "$pcatemptyoutput,0"
}

if ($choice -eq '2') {

  if (-not(Test-Path -Path $pstaremptyoutput -PathType Leaf)) {
    Write-Host "Downloading Patrick Star Empty Icon"
    $url = $pstarempty
    Invoke-WebRequest -Uri $url -OutFile ( New-Item -Path "$pstaremptyoutput" -Force )
  }
  else {
    Write-Host "Patrick Star Empty Icon already exists"
  }

  if (-not(Test-Path -Path $pstarfulloutput -PathType Leaf)) {
    Write-Host "Downloading Patrick Star Full Icon"
    $url = $pstarfull
    Invoke-WebRequest -Uri $url -OutFile ( New-Item -Path "$pstarfulloutput" -Force )
  }
  else {
    Write-Host "Patrick Star Full Icon already exists"
  }

  Write-Host "Setting Registry"
  Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "(Default)" -Value "$pstaremptyoutput,0"
  Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "full" -Value "$pstarfulloutput,0"
  Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "empty" -Value "$pstaremptyoutput,0"
}

if ($choice -eq '3') {

  if (-not(Test-Path -Path $kirbyemptyoutput -PathType Leaf)) {
    Write-Host "Downloading Kirby Empty Icon"
    $url = $kirbyempty
    Invoke-WebRequest -Uri $url -OutFile ( New-Item -Path "$kirbyemptyoutput" -Force )
  }
  else {
    Write-Host "Kirby Empty Icon already exists"
  }

  if (-not(Test-Path -Path $kirbyfulloutput -PathType Leaf)) {
    Write-Host "Downloading Kirby Full Icon"
    $url = $kirbyfull
    Invoke-WebRequest -Uri $url -OutFile ( New-Item -Path "$kirbyfulloutput" -Force )
  }
  else {
    Write-Host "Kirby Full Icon already exists"
  }

  Write-Host "Setting Registry"
  Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "(Default)" -Value "$kirbyemptyoutput,0"
  Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "full" -Value "$kirbyfulloutput,0"
  Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "empty" -Value "$kirbyemptyoutput,0"
}

if ($choice -eq '4') {

  if (-not(Test-Path -Path $skirbyemptyoutput -PathType Leaf)) {
    Write-Host "Downloading Sword Kirby Empty Icon"
    $url = $skirbyempty
    Invoke-WebRequest -Uri $url -OutFile ( New-Item -Path "$skirbyemptyoutput" -Force )
  }
  else {
    Write-Host "Sword Kirby Empty Icon already exists"
  }

  if (-not(Test-Path -Path $skirbyfulloutput -PathType Leaf)) {
    Write-Host "Downloading Sword Kirby Full Icon"
    $url = $skirbyfull
    Invoke-WebRequest -Uri $url -OutFile ( New-Item -Path "$skirbyfulloutput" -Force )
  }
  else {
    Write-Host "Sword Kirby Full Icon already exists"
  }

  Write-Host "Setting Registry"
  Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "(Default)" -Value "$skirbyemptyoutput,0"
  Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "full" -Value "$skirbyfulloutput,0"
  Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "empty" -Value "$skirbyemptyoutput,0"
}

if ($choice -eq '5') {

  if (-not(Test-Path -Path $bulbasaulemptyoutput -PathType Leaf)) {
    Write-Host "Downloading Bulbasaul Empty Icon"
    $url = $bulbasaulempty
    Invoke-WebRequest -Uri $url -OutFile ( New-Item -Path "$bulbasaulemptyoutput" -Force )
  }
  else {
    Write-Host "Bulbasaul Empty Icon already exists"
  }

  if (-not(Test-Path -Path $bulbasaulfulloutput -PathType Leaf)) {
    Write-Host "Downloading Bulbasaul Full Icon"
    $url = $bulbasaulfull
    Invoke-WebRequest -Uri $url -OutFile ( New-Item -Path "$bulbasaulfulloutput" -Force )
  }
  else {
    Write-Host "Bulbasaul Full Icon already exists"
  }

  Write-Host "Setting Registry"
  Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "(Default)" -Value "$bulbasaulemptyoutput,0"
  Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "full" -Value "$bulbasaulfulloutput,0"
  Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "empty" -Value "$bulbasaulemptyoutput,0"
}

if ($choice -eq '6') {

  if (-not(Test-Path -Path $minecraftemptyoutput -PathType Leaf)) {
    Write-Host "Downloading Minecraft Chest Empty Icon"
    $url = $minecraftempty
    Invoke-WebRequest -Uri $url -OutFile ( New-Item -Path "$minecraftemptyoutput" -Force )
  }
  else {
    Write-Host "Minecraft Chest Empty Icon already exists"
  }

  if (-not(Test-Path -Path $minecraftfulloutput -PathType Leaf)) {
    Write-Host "Downloading Minecraft Chest Full Icon"
    $url = $minecraftfull
    Invoke-WebRequest -Uri $url -OutFile ( New-Item -Path "$minecraftfulloutput" -Force )
  }
  else {
    Write-Host "Minecraft Chest Full Icon already exists"
  }

  Write-Host "Setting Registry"
  Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "(Default)" -Value "$minecraftemptyoutput,0"
  Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "full" -Value "$minecraftfulloutput,0"
  Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "empty" -Value "$minecraftemptyoutput,0"
}

if ($choice -eq '7') {

  if (-not(Test-Path -Path $dachshundemptyoutput -PathType Leaf)) {
    Write-Host "Downloading Dachshund Empty Icon"
    $url = $dachshundempty
    Invoke-WebRequest -Uri $url -OutFile ( New-Item -Path "$dachshundemptyoutput" -Force )
  }
  else {
    Write-Host "Dachshund Empty Icon already exists"
  }

  if (-not(Test-Path -Path $dachshundfulloutput -PathType Leaf)) {
    Write-Host "Downloading Dachshund Full Icon"
    $url = $dachshundfull
    Invoke-WebRequest -Uri $url -OutFile ( New-Item -Path "$dachshundfulloutput" -Force )
  }
  else {
    Write-Host "Dachshund Full Icon already exists"
  }

  Write-Host "Setting Registry"
  Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "(Default)" -Value "$dachshundemptyoutput,0"
  Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "full" -Value "$dachshundfulloutput,0"
  Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "empty" -Value "$dachshundemptyoutput,0"
}

if ($choice -eq '9') {
  Write-Host "Resetting to default settings"
  Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "(Default)" -Value "%SystemRoot%\System32\imageres.dll,-55"
  Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "full" -Value "%SystemRoot%\System32\imageres.dll,-54"
  Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "empty" -Value "%SystemRoot%\System32\imageres.dll,-55"
}

#Refresh Desktop
$code = @'
  [System.Runtime.InteropServices.DllImport("Shell32.dll")] 
  private static extern int SHChangeNotify(int eventId, int flags, IntPtr item1, IntPtr item2);

  public static void Refresh()  {
      SHChangeNotify(0x8000000, 0x1000, IntPtr.Zero, IntPtr.Zero);    
  }
'@

Add-Type -MemberDefinition $code -Namespace WinAPI -Name Explorer 
[WinAPI.Explorer]::Refresh()
