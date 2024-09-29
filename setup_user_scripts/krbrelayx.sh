echo =============== KrbRelay
echo "KrbRelay, Press Enter to continue..."
read blaj
cd $HOME/venv
git clone https://github.com/dirkjanm/krbrelayx.git
python3 -m venv krbrelayx
. krbrelayx/bin/activate
cd krbrelayx
pip install impacket ldap3
deactivate
