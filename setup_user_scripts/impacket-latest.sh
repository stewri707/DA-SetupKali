echo ==================== Latest Impacket (with PKCS12 support)
echo "Bloodhoud.py Bloodhound CE Branch. Press Enter"
read blaj
cd $HOME/venv
git clone https://github.com/fortra/impacket.git
python3 -m venv impacket
. impacket/bin/activate 
cd impacket
pip3 install -r requirements.txt
python3 setup.py install
deactivate
