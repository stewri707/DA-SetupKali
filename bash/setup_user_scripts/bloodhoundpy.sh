#!/usr/bin/env bash

echo ==================== Bloodhoud.py Bloodhound CE Branch
echo "Bloodhoud.py Bloodhound CE Branch. Press Enter"
read blaj
cd $HOME/venv
git clone -b bloodhound-ce https://github.com/dirkjanm/BloodHound.py.git
mv BloodHound.py bloodhound.py
python3 -m venv bloodhound.py
.  bloodhound.py/bin/activate
cd bloodhound.py/
pip install .
deactivate
