#!/usr/bin/env bash

echo =============== Responder
echo "Responder, Press Enter to continue..."
read blaj
cd $HOME/venv
rm -rf Responder responder
git clone https://github.com/lgandx/Responder.git
mv Responder responder
python3 -m venv responder
