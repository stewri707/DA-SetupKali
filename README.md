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

## Hyper-V
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

In case of problem for Guest to get IP address,\
disconnect it, and the reconecct it again
```
$VMName = 'MyVm'
$SwitchName = (Get-VMNetworkAdapter -VMName $VMName).SwitchName
Get-VMNetworkAdapter -VMName $VMName | Disconnect-VMNetworkAdapter
Get-VMSwitch -Name $SwitchName | Connect-VMNetworkAdapter -VMName $VMName
```

## Windows
Switch off Multicast/Broadcast Name Resolution
```
# Deactivate NetBIOS with gpedit.msc
		... / Administrative Templates > Network > DNS Client: Configure NetBIOS Settings

# Deactivate LLMNR client with gpedit.msc
		... / Administrative Templates > Network > DNS Client: Turn Off Multicast Name Resolution

# Deactivate mDNS client via Service DNSCache
		Set-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters\ -Name EnableMDNS -Value 0

# Deactivate SSDP:
		Disable relevant Services:
		Set-Service UPNPHost -StartupType Disabled
		Set-Service SSDPSrv -StartupType Disabled # ('SSDP Discovery')
		Note! Will not stop SSDP messages from Edge browser.
```

