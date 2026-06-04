#!/usr/bin/env bash

# =========== Katalog för venv ===========
echo "Make dir for PIPENV, Press Enter to continue..."
read blaj

if [ -d "$HOME/venv" ]; then
    echo "Directory already exists: $HOME/venv"
    
    # Prompt the user for confirmation
    read -p "Do you want to delete all its contents? (y/Y to confirm): " reply
    
    # Check if the user input matches 'y' or 'Y'
    if [ "$reply" = "y" ] || [ "$reply" = "Y" ]; then
        # Deletes all files and subdirectories inside, including hidden files
        find "$HOME/venv" -mindepth 1 -delete
        echo "All contents of $HOME/venv have been deleted."
    else
        echo "Operation canceled. Contents preserved."
    fi
else
    mkdir "$HOME/venv"
    echo "Directory created: $HOME/venv"
fi