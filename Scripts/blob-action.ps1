param([String]$type, [String] $path)

$storageAccountName = "workshopstorage"
$storageAccountKey = "55+ieJPAcPQN620RdmGK6ws9Gg7SSCJEBEmZeI9+r5eBeH33+VuGqjwhISvNsHG9uhKvJkSQX1g4n2CA3OKucg=="
$blobContainerName = "eretailblob"
$blobName = "TestNetCoreAPI.zip"

$systemDirectory = $env:SYSTEM_ARTIFACTSDIRECTORY
$scriptDirectory = "/_ERetail_Tenant_App-CI/drop/"

$storageContext = New-AzStorageContext -StorageAccountName $storageAccountName `
-StorageAccountKey $storageAccountKey

if ($type -eq "upload")
{

    Set-AzStorageBlobContent -File $path -Container $blobContainerName -Blob $blobName `
    -Context $storageContext -Force

}
else
{

    # Set-Location -Path ".."
    # $destinationPath = "$PWD/Bin/$blobName"
    $destinationPath = $systemDirectory + $scriptDirectory + $blobName

    Get-AzStorageBlobContent -Container $blobContainerName -Blob $blobName `
    -Context $storageContext -Destination $destinationPath -Force

    # Set-Location -Path "$PWD/Scripts"
    
}








