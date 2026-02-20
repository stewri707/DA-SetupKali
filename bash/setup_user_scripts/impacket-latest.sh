#!/usr/bin/env bash

echo ================== Impacket Master Branch
echo "Impacket Master Branch, Press Enter to continue..."
read blaj
cd $HOME/venv
mkdir impacket-latest
python3 -m venv impacket-latest
. impacket-latest/bin/activate
cd impacket-latest
pip install impacket
deactivate
