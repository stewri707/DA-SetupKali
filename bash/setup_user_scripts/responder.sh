echo =============== Responder
echo "Responder, Press Enter to continue..."
read blaj
cd $HOME/venv
git clone https://github.com/lgandx/Responder.git
mv Responder responder
python3 -m venv responder
