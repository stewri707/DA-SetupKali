$EcryptionNameHint = 'Encryption Certificate'
$SigningNameHint = 'Signing Certificate'

$path = 'E:\HGSCerts'

$ImportItems = @()


# Get all the .pfx files and group them
Get-ChildItem -Path $path -Filter '*.pfx' |
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

# Display the resulting pairs
foreach ( $ImportItem in $ImportItems )
{
    try
    {
    $Params = @{
        Name                          = $ImportItem.FirstPartInSubject + "($ImportItem.SecondPartInSubject)"
        SigningCertificate            = $ImportItem.SigningFile
        SigningCertificatePassword    = $Password
        EncryptionCertificate         = $ImportItem.EncryptionFile
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