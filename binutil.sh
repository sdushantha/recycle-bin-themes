#!/bin/bash

version=v1.0

ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m"
COL_MAGENTA=$ESC_SEQ"35;01m"


function cecho() {
  echo "$COL_MAGENTA ${1} $COL_RESET"
}


cecho "  ___                _       ___ _        _____ _                     "
cecho " | _ \___ __ _  _ __| |___  | _ |_)_ _   |_   _| |_  ___ _ __  ___ ___"
cecho " |   / -_) _| || / _| / -_) | _ \ | ' \    | | | ' \/ -_) '  \/ -_|_-<"
cecho " |_|_\___\__|\_, \__|_\___| |___/_|_||_|   |_| |_||_\___|_|_|_\___/__/"
cecho "             |__/ $version by TechnoLuc"



PS3='Choose your recycle bin theme: '
themes=("pop-cat" "patrick-star" "dachshund" "minecraft" "french-fries" "mac-pro" "Default" "Quit")
select theme in "${themes[@]}"; do
    case $theme in
        "pop-cat")
            echo "You selected $theme!"
	    # optionally call a function or run some code here
            break
	    ;;
        "patrick-star")
            echo "You selected $theme!"
	    # optionally call a function or run some code here
            break
	    ;;
        "dachshund")
            echo "You selected $theme!"
	    # optionally call a function or run some code here
	    break
	    ;;
        "minecraft")
            echo "You selected $theme!"
	    # optionally call a function or run some code here
	    break
	    ;;
        "french-fries")
            echo "You selected $theme!"
	    # optionally call a function or run some code here
	    break
	    ;;
        "mac-pro")
            echo "You selected $theme!"
	    # optionally call a function or run some code here
	    break
	    ;;
        "Default")
            echo "You selected the default! Reverting to regular recycle bin"
	    # optionally call a function or run some code here
	    break
            ;;
	"Quit")
	    echo "User requested exit"
	    exit
	    ;;
        *) echo "invalid option $REPLY";;
    esac
done
