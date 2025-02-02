# Get repo
git clone https://github.com/stewri707/DA-SetupKali.git

# Kali
```
cd DA-SetupKali
sudo su -
find . -type f -name "*.sh" -exec chmod ug+x {} \;
./setup_root.sh
```

# Destination Host
For each exported HGS Certificate, create HGS
```
$Password = Read-Host -AsSecureString -Prompt "PFX Password"

$Params = @{
    Name                          = $HGSDisplayName # Suggestion: Same as HGS Name as contained in PFX filename
    SigningCertificate            = $PathToSignerCertPFX
    SigningCertificatePassword    = $Password
    EncryptionCertificate         = $PathToEnryptionCertPFX
    EncryptionCertificatePassword = $Password
    Allowexpired                  = $true
    AllowUntrustedRoot            = $true
}

New-HgsGuardian @Params
```
