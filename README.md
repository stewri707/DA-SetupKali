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

Configure Host
```
$VMPath = "C:\Hyper-V\VM\"
Configure-XVMHost -VmPath $VMPath
```

Import Exported VM
```
# Copy the exported VM from source Host to desired destination; Registering of imported VM will be "in-place" (From the place where the import is fron)
Get-ChildItem -Path 'C:\Hyper-V\VM\*' -Include *.vmcx -Recurse | ForEach-Object { Import-VM -Path $_.FullName }
```

In case of problem for GuestVM to get IP address,\
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

Disable Incoming Firewall Rules
```
# Save Names of rules to be disabled
# Generic VM:
Get-NetFirewallRule -Direction Inbound -Action Allow -Enabled True | `
Where-Object { $_.DisplayName -notlike "HNS Container Networking*" } | `
Select-Object -ExpandProperty DisplayName | `
Set-Content C:\Tools\DisabledInboundFirewallRules.txt
# VM to expose RDP:
Get-NetFirewallRule -Direction Inbound -Action Allow -Enabled True | `
Where-Object { $_.DisplayName -notlike "HNS Container Networking*" -and  $_.DisplayName -notlike "Remote Desktop - User Mode*" } | `
Select-Object -ExpandProperty DisplayName | `
Set-Content C:\Tools\DisabledInboundFirewallRules.txt


# Disable Rules
Get-Content -Path C:\Tools\DisabledInboundFirewallRules.txt | `
ForEach-Object { Get-NetFirewallRule -DisplayName $_  | Set-NetFirewallRule -Enabled False}

# In case they need to be enabled again
Get-Content -Path C:\Tools\DisabledInboundFirewallRules.txt | `
ForEach-Object { Get-NetFirewallRule -DisplayName $_  | Set-NetFirewallRule -Enabled True}
```

## Clone (Golden) VM to Production VM
```
# Use DA-HyperV for cloning
$GoldenVM = 'MyVm'
Get-VM -Name $GoldenVM | Clone-XVM -NewVMName "$($$GoldenVM)-1"
# Remove snapshots from Production VM
Get-VMCheckpoint -VMName "$($$GoldenVM)-1" | Remove-VMCheckpoint
```


