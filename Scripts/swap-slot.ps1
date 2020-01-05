param([String]$rg, [string]$app, [String]$source, [String]$dest)

Switch-AzWebAppSlot -SourceSlotName $source -DestinationSlotName $dest `
-ResourceGroupName $rg -Name $app