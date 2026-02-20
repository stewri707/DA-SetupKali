#!/usr/bin/env bash

echo ################ Tools
echo "Install standalone tools, Press Enter to continue..."
read blaj
mkdir $HOME/tools
cd $HOME/tools
curl https://raw.githubusercontent.com/topotam/PetitPotam/refs/heads/main/PetitPotam.py -o PetitPotam.py

