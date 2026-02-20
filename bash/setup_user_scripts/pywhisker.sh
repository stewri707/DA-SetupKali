echo ==================== PyWhisker
echo "PyWhisker, Press Enter to continue..."
read blaj
cd $HOME/venv
git clone https://github.com/ShutdownRepo/pywhisker.git
python3 -m venv pywhisker
. pywhisker/bin/activate
cd pywhisker/
pip install -r requirements.txt
deactivate
