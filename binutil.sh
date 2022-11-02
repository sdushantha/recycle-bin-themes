#!/bin/bash
PS3='Choose your recycle bin theme: '
themes=("pop-cat" "patrick-star" "dachshund" "minecraft" "french-fries" "mac-pro" "Default" "Quit")
select theme in "${themes[@]}"; do
    case $theme in
        "pop-cat")
            echo "You selected $theme!"
	    # optionally call a function or run some code here
            ;;
        "patrick-star")
            echo "You selected $theme!"
	    # optionally call a function or run some code here
            ;;
        "dachshund")
            echo "You selected $theme!"
	    # optionally call a function or run some code here
        "minecraft")
            echo "You selected $theme!"
	    # optionally call a function or run some code here
        "french-fries")
            echo "You selected $theme!"
	    # optionally call a function or run some code here
        "mac-pro")
            echo "You selected $theme!"
	    # optionally call a function or run some code here
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
