# Program funkar ej!
# Framräknad $URI leder till sida med felmeddelande

param(
    $VsixDir = 'C:\Util\VSCodeExtension'
)

# Info on an extension; https://marketplace.visualstudio.com/items?itemName=<ExtensionId>
# Note: Publisher must not contain Space.
$Extensions = @(
    @{Publisher='Microsoft'; Id = 'ms-vscode.PowerShell'},
    @{Publisher='yzhang'; Id = 'yzhang.markdown-all-in-on'}
)

if (Test-Path $VsixDir) {
    if (-not (Get-Item $VsixDir).PSIsContainer) {
        throw "$VsixDir exists and is a file."
    }
}
else
{
    try {
        New-Item -ItemType Directory -Path $VsixDir -ErrorAction Stop | Out-Null
    } catch {
        throw "Failed to create directory: $VsixDir"
    }
}

foreach ( $Extension in $Extensions)
{
    $URI = "https://marketplace.visualstudio.com/_apis/public/gallery/publishers/$($Extension.Publisher)/vsextensions/$($Extension.Name)/latest/vspackage"
    $Destination = Join-Path -Path $VsixDir -ChildPath "$($Extension.Id).vsix"
    curl.exe -L -o $Destination $URI
}