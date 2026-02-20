# Export HGS Certificates from Source
## Export only actively used HGS Certificates
Elevated:  
```
$Password = Read-Host -AsSecureString -Prompt "PFX Password"
$ExportPath = 'E:\HGSCerts'
$ExportDir = if ( -not (Test-Path -Path $ExportPath) ) { New-Item -Type Directory -Path $ExportPath }

$HSGSigningCertName = "Shielded VM Signing Certificate (HsgGuardian For tmpvm) (${Env:COMPUTERNAME})"
$HSGEncryptionCertName = "Shielded VM Encryption Certificate (HsgGuardian For tmpvm) (${Env:COMPUTERNAME})"

$SampleVM = Get-VM -Name "W2k25-tmpl"
$RawKeyProtector = Get-VMKeyProtector -VM $SampleVM
$HSGKeyProtector = ConvertTo-HgsKeyProtector -Bytes $RawKeyProtector

if ( $HSGKeyProtector.Guardians.HasPrivateSigningKey )
{
    $HSGSigningCertThumbPrint = $HSGKeyProtector.Guardians.SigningCertificate.Thumbprint
    $HSGEncryptionCertThumbPrint = $HSGKeyProtector.Guardians.EncryptionCertificate.Thumbprint
}
else
{
    "Cannot find Local KeyProtector. Do not continue!" 
}

Get-Item -Path "Cert:\LocalMachine\Shielded VM Local Certificates\$HSGSigningCertThumbPrint" | `
Export-PfxCertificate -FilePath "${ExportPath}\${HSGSigningCertName}.pfx" -Password $Password

Get-Item -Path "Cert:\LocalMachine\Shielded VM Local Certificates\$HSGEncryptionCertThumbPrint" | `
Export-PfxCertificate -FilePath "${ExportPath}\${HSGEncryptionCertName}.pfx" -Password $Password
```

## Export all HGS Certificates
Elevated:  
```
$Password = Read-Host -AsSecureString -Prompt "PFX Password"
$ExportPath = 'E:\HSGCerts'
if ( -not (Test-Path -Path $ExportPath) ) { New-Item -Type Directory -Path $ExportPath }

# Created PFX filename(s) will be the same as certificate Subject Name
Get-ChildItem 'Cert:\LocalMachine\Shielded VM Local Certificates' | ForEach-Object {
    Export-PfxCertificate -Cert $_ -FilePath "${ExportPath}\$($_.Subject).pfx" -Password $Password
}
```

# Hyper-V APF

## Import HGS Certificates
For each exported HGS Certificate, create HGS
```
.\PS\Import-HGSCerts.ps1 -ImportPath E:\HGSCerts\
```

## Configure Hyper-V Host
```
$VMPath = "C:\Hyper-V\VM\"
Configure-XVMHost -VmPath $VMPath
```

## Import Exported VM
```
# Copy the exported VM from source Host to desired destination; Registering of imported VM will be "in-place" (From the place where the import is fron)
Get-ChildItem -Path 'C:\Hyper-V\VM\*' -Include *.vmcx -Recurse | ForEach-Object { Import-VM -Path $_.FullName }

# Or, if the same exported VM is to be importible multiple times, it must be assiged an unique Id
# The VM files will now be crfeated in their default locations
Import-VM -Path "E:\ExportedVMs\Path-To-vmcx-File" -Copy -GenerateNewId
```

In case of problem for GuestVM to get IP address,\
disconnect it, and the reconecct it again
```
$VMName = 'MyVm'
$SwitchName = (Get-VMNetworkAdapter -VMName $VMName).SwitchName
Get-VMNetworkAdapter -VMName $VMName | Disconnect-VMNetworkAdapter
Get-VMSwitch -Name $SwitchName | Connect-VMNetworkAdapter -VMName $VMName
```

## Clone (Golden) VM to Production VM
```
# Use DA-HyperV for cloning
$GoldenVM = 'MyVm'
Get-VM -Name $GoldenVM | Clone-XVM -NewVMName "$($$GoldenVM)-1"
# Remove snapshots from Production VM
Get-VMCheckpoint -VMName "$($$GoldenVM)-1" | Remove-VMCheckpoint
```

# Networking APF and VM

## Switch Off MCast
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

## Disable Incoming Firewall Rules

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
