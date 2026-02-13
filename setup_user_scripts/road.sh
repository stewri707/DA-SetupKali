echo ================== ROADrecon, Roadtx

echo "ROADrecon, Press Enter to continue..."
read blaj
cd $HOME/venv
mkdir roadrecon
python3 -m venv roadrecon
. roadrecon/bin/activate
cd roadrecon
pip install roadlib
pip install roadrecon
deactivate

echo "Roadtx, Press Enter to continue..."
read blaj
cd $HOME/venv
mkdir roadtx
python3 -m venv roadtx
. roadtx/bin/activate
cd roadtx
pip install roadlib
pip install roadtx
deactivate
