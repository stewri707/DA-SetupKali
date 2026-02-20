#!/usr/bin/env bash

echo ================ LdapRelayScan
echo "LdapRelayScan, Press Enter to continue..."
read blaj
cd $HOME/venv
git clone https://github.com/zyn3rgy/LdapRelayScan.git
mv LdapRelayScan ldaprelayscan
python3 -m venv ldaprelayscan
. ldaprelayscan/bin/activate
cd ldaprelayscan
pip install -r requirements_exact.txt
deactivate
