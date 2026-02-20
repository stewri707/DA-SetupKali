echo ================== bloodyAD
echo "bloodyAD, Press Enter to continue..."
read blaj
cd $HOME/venv
mkdir bloodyAD
python3 -m venv bloodyAD
. bloodyAD/bin/activate
cd bloodyAD
pip install bloodyAD
deactivate
