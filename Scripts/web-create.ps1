param([String]$cust = "Cust" + $(Get-Random), [String]$rg = "RG" + $(Get-Random), `
[String]$loc = "South India")

$webappToken = "eretail-web-"
$webappName = $webappToken + $cust
$appPlanToken = "eretail-app-plan-"
$appPlanName = $appPlanToken + $(Get-Random)
$appPlanTier = "Standard"
$slotDev = "DEV"
$slotQa = "QA"
$slotPreProd = "Pre-PROD"
$uploadCommand = "upload"
$blobPath = "/Users/monojitdattams/Development/Projects/Extras/TestNetCoreAPI.zip"
$uploadScriptCommand = "$PWD/blob-action.ps1 -type $uploadCommand -path $blobPath"

$rgRef = Get-AzResourceGroup -Name $rg -Location $loc
if (!$rgRef)
{
    $rgRef = New-AzResourceGroup -Name $rg -Location $loc

}

$webappRef = Get-AzWebApp -ResourceGroupName $rg -Name $webappName
if ($webappRef)
{
    Invoke-Expression -Command  $uploadScriptCommand
    return;
    
}

$appPlanRef = New-AzAppServicePlan -ResourceGroupName $rg -Name $appPlanName `
-Location $loc -Tier $appPlanTier
if (!$appPlanRef)
{
    Write-Host "Error creating App Service Plan"
    return;

}

$webappRef = New-AzWebApp -ResourceGroupName $rg -Name $webappName -AppServicePlan $appPlanName `
-Location $loc
if (!$webappRef)
{
    Write-Host "Error creating Web App"
    return;

}

New-AzWebAppSlot -ResourceGroupName $rg -Slot $slotDev -Name $webappName
New-AzWebAppSlot -ResourceGroupName $rg -Slot $slotQa -Name $webappName
New-AzWebAppSlot -ResourceGroupName $rg -Slot $slotPreProd -Name $webappName

Invoke-Expression -Command  $uploadScriptCommand
Write-Host $webappName
