import json
import subprocess
import requests
from tkinter import *
from platform import system
from pathlib import Path
import os


recycle_bin_themes_dir = str(Path.home()) + os.path.sep + "Pictures" + os.path.sep + "RecycleBinThemes"

def isWindows() -> bool:
    """
    Check if the system the program is running on is Windows
    """
    return system() == "Windows"


def execPowershellCmd(command):
    results = subprocess.run(["powershell", "-Command"] + command.split(), capture_output=True)
    return results 


def updateLocalThemes():
    """
    Download all themes to to Pictures folder. This way, the user doesn't require
    internet to use the app
    """

    # TODO: fetch this from GitHub instead of using local one so that
    #       the user can download the most up to date themes
    with open("data.json", "r") as f:
        themes = json.load(f)["themes"]

    for theme_code in themes:
        # Directory where the icons and the preview GIF will be stored
        theme_dir = recycle_bin_themes_dir + os.path.sep + theme_code

        # Create the theme's directory even though it may already exist 
        os.makedirs(theme_dir, exist_ok=True)

        # Path where the icon will be saved
        empty_icon_path =  theme_dir + os.path.sep + f"{theme_code}-empty.ico"
        full_icon_path = theme_dir + os.path.sep + f"{theme_code}-full.ico"
        preview_gif_path =  theme_dir + os.path.sep + "preview.gif"

        # Downloaded all the files
        r = requests.get(f"https://raw.githubusercontent.com/sdushantha/recycle-bin-themes/main/themes/{theme_code}/{theme_code}-empty.ico")
        open(empty_icon_path, "wb").write(r.content)

        r = requests.get(f"https://raw.githubusercontent.com/sdushantha/recycle-bin-themes/main/themes/{theme_code}/{theme_code}-full.ico")
        open(full_icon_path, "wb").write(r.content)

        r = requests.get(f"https://raw.githubusercontent.com/sdushantha/recycle-bin-themes/main/themes/{theme_code}/preview.gif")
        open(preview_gif_path, "wb").write(r.content)

        print("Downloaded:", theme_code)


def setDefaultTheme():
    """
    Change the theme back to the default Recycle Bin icon
    """
    writeToDefaultIconRegistry("(Default)", "%SystemRoot%\System32\imageres.dll,-55")
    writeToDefaultIconRegistry("full", "%SystemRoot%\System32\imageres.dll,-54")
    writeToDefaultIconRegistry("empty", "%SystemRoot%\System32\imageres.dll,-55")
    reloadExplorer()


def setTheme(theme_code):
    """
    Set theme by theme name

    theme_code   str   The code name of the theme name (example: patrick-star)
    """

    empty_icon_path = recycle_bin_themes_dir + os.path.sep + theme_code + os.path.sep + f"{theme_code}-empty.ico"
    full_icon_path = recycle_bin_themes_dir + os.path.sep + theme_code + os.path.sep + f"{theme_code}-full.ico"

    writeToDefaultIconRegistry("(Default)", f"{empty_icon_path},0")
    writeToDefaultIconRegistry("full", f"{full_icon_path},0")
    writeToDefaultIconRegistry("empty", f"{empty_icon_path},0")
    reloadExplorer()


def writeToDefaultIconRegistry(name, value) -> bool:
    """
    Function for writing to the Registry.
    """
    exit_status = execPowershellCmd(f"Set-ItemProperty -Path 'Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{{645FF040-5081-101B-9F08-00AA002F954E}}\DefaultIcon' -Name '{name}' -Value '{value}'").returncode
    return exit_status == 0


def reloadExplorer() -> bool:
    """
    Reload explorer so that edited Registry gets applied
    """
    exit_status = execPowershellCmd("Stop-Process -ProcessName explorer -Force")
    return exit_status == 0

def main():
    #TODO: write the rest of the code

    # Always make sure to create our "home" dir
    os.makedirs(recycle_bin_themes_dir, exist_ok=True)
    #if first time running program, then update themes
    #updateLocalThemes()