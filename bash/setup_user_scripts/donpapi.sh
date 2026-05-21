#!/usr/bin/env bash

echo ================ DonPAPI
echo "DonPAPI, Press Enter to continue..."
read blaj
cd $HOME/venv
rm -rf donpapi
mkdir donpapi
python3 -m venv donpapi
. donpapi/bin/activate
cd donpapi
pip install DonPAPI
deactivate
