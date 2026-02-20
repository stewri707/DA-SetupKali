#!/usr/bin/env bash

echo ==================== GPOddity.py
echo "GPOddity.py. Press Enter"
read blaj
cd $HOME/venv
git clone https://github.com/synacktiv/GPOddity
python3 -m venv GPOddity
.  GPOddity/bin/activate
cd GPOddity/
pip install -r requirements.txt
deactivate
