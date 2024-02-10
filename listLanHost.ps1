$ip123 = "192.168.3."

function getHostName($ip4) {
    $ip = $ip123+$ip4 
    try {
        $result=Resolve-DnsName $ip -ErrorAction Stop
        return $result.namehost
    }
    catch {
        return "not found"
    }
}

function existsHost($ip4){
    $ip = $ip123 + $ip4
    $result = Test-NetConnection $ip -ErrorAction Stop
    return $result.PingSucceeded
}

function showIpStatus($ip4) {
    $exist = existsHost $ip4
    $hostName = getHostName $ip4
    $ip = $ip123 + $ip4
    $result = $ip + ", " + $hostName + ", " + $exist
    return $result
}

for ($i = 0; $i -lt 255; $i++) {
    $result = showIpStatus $i
    Write-Host $result
}