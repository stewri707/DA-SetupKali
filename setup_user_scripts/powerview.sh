echo ==================== Powerview.py
echo "Powerview.py, Press Enter to continue..."
read blaj
cd $HOME/venv
mkdir powerview
python3 -m venv powerview
. powerview/bin/activate
cd powerview/
pip install powerview
deactivate
