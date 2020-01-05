param([String]$rg, [String]$app, [String]$file, [string]$slot)

$downloadScriptName = "blob-action.ps1"
# $downloadScriptPath = "$PWD/$downloadScriptName"

$systemDirectory = $env:SYSTEM_ARTIFACTSDIRECTORY
$scriptDirectory = "/_ERetail_Tenant_App-CI/drop/"
$downloadScriptPath = $systemDirectory + $scriptDirectory + $downloadScriptName

Invoke-Expression -Command $downloadScriptPath

# Set-Location -Path ".."
# $archivePath = "$PWD/Bin/$file"
$archivePath = $systemDirectory + $scriptDirectory + $file

Publish-AzWebApp -ResourceGroupName $rg -Name $app -ArchivePath $archivePath -Slot $slot -Force

# Set-Location -Path "$PWD/Scripts"