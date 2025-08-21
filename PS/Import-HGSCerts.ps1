param(
    # Directory to import HGS Certificates from
    $ImportPath = 'E:\HGSCerts'
)

# Ensure the script is running as administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "You must run $($MyInvocation.MyCommand.Name) as an administrator!"
    exit
}

<# 
The following are assumptions on file names:
Files come in pair with names like:
"XXX Encryption Certificate (Something interesting regarding source) (Something interesting regarding source).pfx"
"XXX Signing Certificate (Something interesting regarding source) (Something interesting regarding source).pfx"
#>
$EcryptionNameHint = 'Encryption Certificate'
$SigningNameHint = 'Signing Certificate'

$Password = Read-Host -AsSecureString -Prompt "PFX Password"

$ImportItems = @()

# Get all the .pfx files and group them
Get-ChildItem -Path $ImportPath -Filter '*.pfx' |
    # Treat all pairs (Files with same name except for ' $EcryptionNameHint ' and ' $SigningNameHint ' parts )
    Group-Object { $_.Name -replace " $EcryptionNameHint " -replace " $SigningNameHint " } |
    ForEach-Object {
        # Create a custom object for each pair
        try
        {
            $GroupingKey    = $_.Name

            $CurrentItem = [PSCustomObject]@{
                EncryptionFile = $_.Group | Where-Object { $_.Name -like "*$($EcryptionNameHint)*" }
                SigningFile    = $_.Group | Where-Object { $_.Name -like "*$($SigningNameHint)*" }
                FirstPartInSubject       = ($_.Name -split '[()]')[1] # Text within within 1st ( )
                SecondPartInSubject       = ($_.Name -split '[()]')[3] # Text within within 2nd ( )
                GroupingKey    = $GroupingKey
            }

            Write-Host "Import the Following Item? (y|N)"
            $currentItem | Select-Object * -ExcludeProperty GroupingKey | Format-List
            
            if ([console]::ReadKey($true).Key -eq 'Y')
            {
                $ImportItems += $CurrentItem
            }
        }
        catch
        {
            Write-Warning "Failed to create an import item for: $GroupingKey"
        }
    }

foreach ( $ImportItem in $ImportItems )
{
    try
    {
    $Params = @{
        Name                          = $ImportItem.FirstPartInSubject + "($ImportItem.SecondPartInSubject)"
        SigningCertificate            = Join-Path -Path $ImportPath -ChildPath $ImportItem.SigningFile
        SigningCertificatePassword    = $Password
        EncryptionCertificate         = Join-Path -Path $ImportPath -ChildPath $ImportItem.EncryptionFile
        EncryptionCertificatePassword = $Password
        Allowexpired                  = $true
        AllowUntrustedRoot            = $true
    }
    New-HgsGuardian @Params
    }
    catch
    {
        Write-Warning "Failed to import item for: $($ImportItem.GroupingKey)"
    }
}