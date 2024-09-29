echo ================ WebclientServiceScanner
echo "WebclientServiceScanner, Press Enter to continue..."
read blaj
cd $HOME/venv
git clone https://github.com/Hackndo/WebclientServiceScanner.git
mv WebclientServiceScanner webclientServiceScanner
python3 -m venv webclientServiceScanner
. webclientServiceScanner/bin/activate
cd webclientServiceScanner
pip install .
deactivate
