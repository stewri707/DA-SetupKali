echo ==================== PKINITtools
echo "PKInitTools, Press Enter to continue..."
read blaj
cd $HOME/venv
git clone https://github.com/dirkjanm/PKINITtools.git
mv PKINITtools pkinittools
python3 -m venv pkinittools
. pkinittools/bin/activate
cd pkinittools/
pip install -r requirements.txt
deactivate
