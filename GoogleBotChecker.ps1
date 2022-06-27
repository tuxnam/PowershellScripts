#
# This scripts verifies DNS resolution of an IP and reverse DNS the resolved hostname, to confirm it matches the original IP
# Example for Google DNS
#

# IP to verify 
$computerIPAddress = "XXX.XXX.XXX.XXX"

# Following https://developers.google.com/search/docs/advanced/crawling/verifying-googlebot
# Step 1: Reverse DNS lookup on target IP
# Step 2: Forward DNS lookup on resolved hostname
# Step 3: Verify that Reverse DNS resolves to google.com or googlebot.com AND forward DNS on resolved hostname equals target IP
try{
    $resolveBotOrigin = [System.Net.Dns]::GetHostEntry($computerIPAddress)[0].HostName
    $resolvedOriginIP = (Resolve-DnsName $resolveBotOrigin)[0].IPAddress

    if($resolveBotOrigin.ToLower() -like '*google.com' -And $resolvedOriginIP -eq $computerIPAddress){
        Write-Host 'Google Bot'
    }elseif($resolveBotOrigin.ToLower() -like '*googlebot.com' -And $resolvedOriginIP -eq $computerIPAddress){
        Write-Host 'Google Bot 2'
    }else{
        Write-Host 'Malicious IP'
    }

}catch { Write-Host 'Error in the command or provided IP could not be resolved.' }
