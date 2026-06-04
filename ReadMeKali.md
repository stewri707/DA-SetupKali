# Kali
```
# As root
sudo su -
apt update
cd ~localuser/DA-SetupKali
git fetch
git pull

cd ~localuser/DA-SetupKali/bash
find . -type f -name "*.sh" -exec chmod ug+x {} \;
./setup_root.sh

# No longer as root
logout

cd ~localuser/DA-SetupKali/bash
./setup_user.sh

# Finally as root again if fzf is working correctly for localuser,
# configure bash and zsh to use fzf
# Check in setup_user.sh the correct path, but probably:
~localuser/DA-SetupKali/bash/setup_user_scripts/setup_fzf/fzf.sh

```

