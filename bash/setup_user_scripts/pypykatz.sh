#!/usr/bin/env bash

echo ============ PypyKatz
echo "PypyKatz, Press Enter to continue..."
read blaj
cd $HOME/venv
git clone https://github.com/skelsec/pypykatz.git
python3 -m venv pypykatz
. pypykatz/bin/activate
cd pypykatz/
pip3 install minidump minikerberos aiowinreg msldap winacl
deactivate
