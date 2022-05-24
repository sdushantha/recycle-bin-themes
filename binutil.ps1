##################################################################################################################
# THIS IS A SCRIPT TO AUTOMATE THE PROCESS OF https://github.com/technoluc/recycle-bin-themes                   #
# PLEASE SEE https://www.reddit.com/r/pcmasterrace/comments/uw2se4/i_made_a_patrick_star_version_of_the_cat_bin/ #
##################################################################################################################

#Check for Administrator privileges and if not, open powershell as admin and rerun the script
Write-Host "Checking for elevated privileges" 
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	Exit
}

# Set the working location to the same location as the script
# Write-Host "Setting Working Directory to Script Root"
# Set-Location $PSScriptRoot

#Get .ico files from github the hard way

#pop-cat-empty.ico
$pcatempty = "https://raw.githubusercontent.com/technoluc/recycle-bin-themes/main/themes/pop-cat/pop-cat-empty.ico"

#pop-cat-full.ico
$pcatfull = "https://raw.githubusercontent.com/technoluc/recycle-bin-themes/main/themes/pop-cat/pop-cat-full.ico"

#patrik-star-empty.ico
$pstarempty = "https://raw.githubusercontent.com/technoluc/recycle-bin-themes/main/themes/patrick-star/patrick-star-empty.ico"

#patrik-star-full.ico
$pstarfull = "https://raw.githubusercontent.com/technoluc/recycle-bin-themes/main/themes/patrick-star/patrick-star-full.ico"

#kirby-empty.ico
$kirbyempty = "https://raw.githubusercontent.com/technoluc/recycle-bin-themes/main/themes/kirby/kirby-empty.ico"

#kirby-full.ico
$kirbyfull = "https://raw.githubusercontent.com/technoluc/recycle-bin-themes/main/themes/kirby/kirby-full.ico"

#sword-kirby-empty.ico
$skirbyempty = "https://raw.githubusercontent.com/technoluc/recycle-bin-themes/main/themes/sword-kirby/sword-kirby-empty.ico"

#sword-kirby-full.ico
$skirbyfull = "https://raw.githubusercontent.com/technoluc/recycle-bin-themes/main/themes/sword-kirby/sword-kirby-full.ico"

#bulbasaul-empty.ico
$bulbasaulempty = "https://raw.githubusercontent.com/technoluc/recycle-bin-themes/main/themes/bulbasaul/bulbasaul-empty.ico"

#bulbasaul-full.ico
$bulbasaulfull = "https://raw.githubusercontent.com/technoluc/recycle-bin-themes/main/themes/bulbasaul/bulbasaul-full.ico"

#minecraft-empty.ico
$minecraftempty = "https://raw.githubusercontent.com/technoluc/recycle-bin-themes/main/themes/minecraft-chest/minecraft-chest-empty.ico"

#minecraft-full.ico
$minecraftfull = "https://raw.githubusercontent.com/technoluc/recycle-bin-themes/main/themes/minecraft-chest/minecraft-chest-full.ico"

#dachshund-empty.ico
$dachshundempty = "https://raw.githubusercontent.com/technoluc/recycle-bin-themes/main/themes/dachshund/dachshund-empty.ico"

#dachshund-full.ico
$dachshundfull = "https://raw.githubusercontent.com/technoluc/recycle-bin-themes/main/themes/dachshund/dachshund-full.ico"

#Get user choice
Write-Host "Please choose your theme:"
$choice = $(Write-Host "[1]Pop-Cat `n[2]Patrik Star `n[3]Kirby `n[4]Sword Kirby `n[5]Bulbasaul `n[6]Minecraft Chest `n[7]Dachshund `n[9]Default " -ForegroundColor Yellow) + $(Write-Host "Choice: " -NoNewLine; Read-Host)
if ($choice -eq '1' -or $choice -eq '2' -or $choice -eq '3' -or $choice -eq '4' -or $choice -eq '5' -or $choice -eq '6' -or $choice -eq '7' -or $choice -eq '9') {
Write-Host "You picked" $choice
}else{
Write-Host "You picked" $choice 
Write-Host "Please enter 1, 2, 3, 4, 5, 6, 7 or 9."
}

if ($choice -eq '1')
{
Write-Host "Downloading pop-cat Empty Icon"
$url = $pcatempty
$output = "$env:userprofile\icons\pop-cat-empty.ico"
Invoke-WebRequest -Uri $url -OutFile ( New-Item -Path "$output" -Force )
Write-Host "Downloading pop-cat Full Icon"
$url = $pcatfull
$output = "$env:userprofile\icons\pop-cat-full.ico"
Write-Host "Setting Registry"
Invoke-WebRequest -Uri $url -OutFile ( New-Item -Path "$output" -Force )
Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "(Default)" -Value "$env:userprofile\icons\pop-cat-empty.ico,0"
Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "full" -Value "$env:userprofile\icons\pop-cat-full.ico,0"
Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "empty" -Value "$env:userprofile\icons\pop-cat-empty.ico,0"
}

if ($choice -eq '2')
{
Write-Host "Downloading Patrik Star Empty Icon"
$url = $pstarempty
$output = "$env:userprofile\icons\patrik-star-empty.ico"
Invoke-WebRequest -Uri $url -OutFile ( New-Item -Path "$output" -Force )
Write-Host "Downloading Patrik Star Full Icon"
$url = $pstarfull
$output = "$env:userprofile\icons\patrik-star-full.ico"
Write-Host "Setting Registry"
Invoke-WebRequest -Uri $url -OutFile ( New-Item -Path "$output" -Force )
Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "(Default)" -Value "$env:userprofile\icons\patrik-star-empty.ico,0"
Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "full" -Value "$env:userprofile\icons\patrik-star-full.ico,0"
Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "empty" -Value "$env:userprofile\icons\patrik-star-empty.ico,0"
}

if ($choice -eq '3')
{
Write-Host "Downloading Kirby Empty Icon"
$url = $kirbyempty
$output = "$env:userprofile\icons\kirby-empty.ico"
Invoke-WebRequest -Uri $url -OutFile ( New-Item -Path "$output" -Force )
Write-Host "Downloading Kirby Full Icon"
$url = $kirbyfull
$output = "$env:userprofile\icons\kirby-full.ico"
Write-Host "Setting Registry"
Invoke-WebRequest -Uri $url -OutFile ( New-Item -Path "$output" -Force )
Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "(Default)" -Value "$env:userprofile\icons\kirby-empty.ico,0"
Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "full" -Value "$env:userprofile\icons\kirby-full.ico,0"
Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "empty" -Value "$env:userprofile\icons\kirby-empty.ico,0"
}

if ($choice -eq '4')
{
Write-Host "Downloading Sword Kirby Empty Icon"
$url = $skirbyempty
$output = "$env:userprofile\icons\sword-kirby-empty.ico"
Invoke-WebRequest -Uri $url -OutFile ( New-Item -Path "$output" -Force )
Write-Host "Downloading Sword Kirby Full Icon"
$url = $skirbyfull
$output = "$env:userprofile\icons\sword-kirby-full.ico"
Write-Host "Setting Registry"
Invoke-WebRequest -Uri $url -OutFile ( New-Item -Path "$output" -Force )
Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "(Default)" -Value "$env:userprofile\icons\sword-kirby-empty.ico,0"
Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "full" -Value "$env:userprofile\icons\sword-kirby-full.ico,0"
Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "empty" -Value "$env:userprofile\icons\sword-kirby-empty.ico,0"
}

if ($choice -eq '5')
{
Write-Host "Downloading Bulbasaul Empty Icon"
$url = $bulbasaulempty
$output = "$env:userprofile\icons\bulbasaul-empty.ico"
Invoke-WebRequest -Uri $url -OutFile ( New-Item -Path "$output" -Force )
Write-Host "Downloading Bulbasaul Full Icon"
$url = $bulbasaulfull
$output = "$env:userprofile\icons\bulbasaul-full.ico"
Write-Host "Setting Registry"
Invoke-WebRequest -Uri $url -OutFile ( New-Item -Path "$output" -Force )
Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "(Default)" -Value "$env:userprofile\icons\bulbasaul-empty.ico,0"
Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "full" -Value "$env:userprofile\icons\bulbasaul-full.ico,0"
Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "empty" -Value "$env:userprofile\icons\bulbasaul-empty.ico,0"
}

if ($choice -eq '6')
{
Write-Host "Downloading Minecraft Chest Empty Icon"
$url = $minecraftempty
$output = "$env:userprofile\icons\minecraft-chest-empty.ico"
Invoke-WebRequest -Uri $url -OutFile ( New-Item -Path "$output" -Force )
Write-Host "Downloading Minecraft Chest Full Icon"
$url = $minecraftfull
$output = "$env:userprofile\icons\minecraft-chest-full.ico"
Write-Host "Setting Registry"
Invoke-WebRequest -Uri $url -OutFile ( New-Item -Path "$output" -Force )
Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "(Default)" -Value "$env:userprofile\icons\minecraft-chest-empty.ico,0"
Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "full" -Value "$env:userprofile\icons\minecraft-chest-full.ico,0"
Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "empty" -Value "$env:userprofile\icons\minecraft-chest-empty.ico,0"
}

if ($choice -eq '6')
{
Write-Host "Downloading Dachshund Empty Icon"
$url = $dachshundempty
$output = "$env:userprofile\icons\dachshund-empty.ico"
Invoke-WebRequest -Uri $url -OutFile ( New-Item -Path "$output" -Force )
Write-Host "Downloading Dachshund Full Icon"
$url = $dachshundfull
$output = "$env:userprofile\icons\dachshund-full.ico"
Write-Host "Setting Registry"
Invoke-WebRequest -Uri $url -OutFile ( New-Item -Path "$output" -Force )
Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "(Default)" -Value "$env:userprofile\icons\dachshund-empty.ico,0"
Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "full" -Value "$env:userprofile\icons\dachshund-full.ico,0"
Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "empty" -Value "$env:userprofile\icons\
dachshund-empty.ico,0"
}

if ($choice -eq '9')
{
Write-Host "Resetting to default settings"
Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "(Default)" -Value "%SystemRoot%\System32\imageres.dll,-55"
Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "full" -Value "%SystemRoot%\System32\imageres.dll,-54"
Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon" -Name "empty" -Value "%SystemRoot%\System32\imageres.dll,-55"
}

#Computer\HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon
#Default
#(Default) = %SystemRoot%\System32\imageres.dll,-55
#empty = %SystemRoot%\System32\imageres.dll,-55
#full = %SystemRoot%\System32\imageres.dll,-54

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
