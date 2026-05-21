#!/usr/bin/env bash
echo ==================== passthecert.py
echo "passthecert.py. Press Enter"
read blaj
cd $HOME/venv
rm -rf PassTheCert passthecert
git clone https://github.com/AlmondOffSec/PassTheCert/
mv PassTheCert passthecert
python3 -m venv passthecert
.  passthecert/bin/activate
cd passthecert/
pip install impacket
deactivate
