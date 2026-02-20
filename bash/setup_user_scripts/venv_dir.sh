#!/usr/bin/env bash

# =========== Katalog för venv ===========
echo "Make dir for PIPENV, Press Enter to continue..."
read blaj
if [ -d "$HOME/venv" ]; then
	echo "Directory already exists: $HOME/venv"
else
	mkdir "$HOME/venv"
	echo "Directory created: $HOME/venv"
fi
