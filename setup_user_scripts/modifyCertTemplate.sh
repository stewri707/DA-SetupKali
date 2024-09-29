echo ========================== modifyCertTemplate
echo "modifyCertTemplate, Press Enter to continue..."
read blaj
cd $HOME/venv
git clone https://github.com/fortalice/modifyCertTemplate.git
python3 -m venv modifyCertTemplate
. modifyCertTemplate/bin/activate
cd modifyCertTemplate/
pip install -r requirements.txt
deactivate
