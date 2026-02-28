#!/usr/bin/env bash

echo ==================== Certipy ====================
echo "Certipy, Press Enter to continue..."
read blaj
cd $HOME/venv
mkdir certipy
python3 -m venv certipy
. certipy/bin/activate
cd certipy/
pip install certipy-ad
deactivate
