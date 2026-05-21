# Kali
```
cd ~/DA-SetupKali/bash

# As root
sudo su -
cd ~localuser/DA-SetupKali/bash
find . -type f -name "*.sh" -exec chmod ug+x {} \;
./setup_root.sh

# No longer as root
logout
cd ~localuser/DA-SetupKali/bash
./setup_user.sh

```