# Get repo
git clone https://github.com/stewri707/DA-SetupKali.git

# Kali
```
cd DA-SetupKali
sudo su -
find . -type f -name "*.sh" -exec chmod ug+x {} \;
./setup_root.sh
```

# Source Host
Export all HGS Certificates
```
$Password = Read-Host -AsSecureString -Prompt "PFX Password"

# Created PFX filename(s) will be the same as certificate Subject Name
Get-ChildItem 'Cert:\LocalMachine\Shielded VM Local Certificates' | ForEach-Object {
    Export-PfxCertificate -Cert $_ -FilePath "c:\HGSCerts\$($_.Subject).pfx" -Password $Password
}
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
