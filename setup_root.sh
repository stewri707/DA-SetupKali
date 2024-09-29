#  =========== Timezone ===========
echo "Timezone, Press Enter to continue..."
read blaj
timedatectl set-timezone Europe/Stockholm

# =========== Uppgradera ===========
echo "Upgrade Kali, Press Enter to continue..."
read blaj
apt-get update
apt-get upgrade

# =========== Kali-paket ===========
echo "Install Kali packages, Press Enter to continue..."
read blaj
# Kommentarer: wordlists, gcc (För blaa krb5-config -> bloodyAD), krb5-user (För blaa kvno, kinit), libkrb5-dev (För blaa bloodyAD, pywerview.py)
apt-get install coercer gcc krb5-user libkrb5-dev libsasl2-modules-gssapi-mit python3-venv pipx pipenv systemd-timesyncd tshark mitm6

# =========== Ordlistor ===========
echo "Wordlists, Press Enter to continue..."
read blaj
# rockyou.txt.gz kommer med wordlists
cd /usr/share/wordlists/
gunzip rockyou.txt.gz

# =========== Extra kommandon ===========
echo "Do extra commands, Press Enter to continue..."
read blaj
chmod +x /usr/share/doc/python3-impacket/examples/ntlmrelayx.py

# =========== PATH ===========
echo "Change PATH, Press Enter to continue..."
read blaj
echo 'PATH=$PATH:"/usr/share/doc/python3-impacket/examples"' > /etc/profile.d/stewripathmodify.sh
echo 'PATH=$PATH:"/home/kali/tools"' >> /etc/profile.d/stewripathmodify.sh

# =========== Powershell hjälp ===========
echo "Install PS Help, Press Enter to continue..."
read blaj
pwsh -Command "Update-help -Module * -Scope AllUsers -UICulture en-us -Force"

