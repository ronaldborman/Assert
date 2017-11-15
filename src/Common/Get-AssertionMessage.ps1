function Get-AssertionMessage ($Expected, $Actual, $Option, [hashtable]$Data = @{}, $CustomMessage, $DefaultMessage, [switch]$Pretty) 
{
    if (-not $CustomMessage)
    {
        $CustomMessage = $DefaultMessage
    }
    
    $expectedFormatted = Format-Custom -Value $Expected -Pretty:$Pretty
    $actualFormatted = Format-Custom -Value $Actual -Pretty:$Pretty

    $optionMessage = $null;
    if ($null -ne $Option)
    {
        $optionMessage = "Used options: $($Option -join ", ")."
    }


    $CustomMessage = $CustomMessage.Replace('<expected>', $expectedFormatted)
    $CustomMessage = $CustomMessage.Replace('<actual>', $actualFormatted)
    $CustomMessage = $CustomMessage.Replace('<expectedType>', (Get-ShortType -Value $Expected))
    $CustomMessage = $CustomMessage.Replace('<actualType>', (Get-ShortType -Value $Actual))
    $CustomMessage = $CustomMessage.Replace('<options>', $optionMessage)

    foreach ($pair in $Data.GetEnumerator())
    {
        $CustomMessage = $CustomMessage.Replace("<$($pair.Key)>", (Format-Custom -Value $pair.Value))
    }

    $CustomMessage
}