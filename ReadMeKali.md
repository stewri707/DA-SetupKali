# Kali
```
cd DA-SetupKali/bash

# As root
sudo su -
find . -type f -name "*.sh" -exec chmod ug+x {} \;
./setup_root.sh

# No longer as root
./setup_user.sh

```