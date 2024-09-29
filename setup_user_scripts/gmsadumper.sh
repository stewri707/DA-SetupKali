echo ============ gMSADumper
echo "gMSADumper, Press Enter to continue..."
read blaj
cd $HOME/venv
git clone https://github.com/micahvandeusen/gMSADumper.git
mv gMSADumper gmsadumper
python3 -m venv gmsadumper
. gmsadumper/bin/activate
cd gmsadumper/
pip install -r requirements.txt
deactivate
