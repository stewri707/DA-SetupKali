#!/usr/bin/env bash

echo ================== ROADrecon, Roadtx

echo "ROADrecon, Press Enter to continue..."
read blaj
cd $HOME/venv
rm -rf roadrecon
mkdir roadrecon
python3 -m venv roadrecon
. roadrecon/bin/activate
cd roadrecon
pip install roadlib
pip install roadrecon
deactivate

echo "Roadtx, Press Enter to continue..."
read blaj
cd $HOME/venv
rm -rf roadtx
mkdir roadtx
python3 -m venv roadtx
. roadtx/bin/activate
cd roadtx
pip install roadlib
pip install roadtx
deactivate
