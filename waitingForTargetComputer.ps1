$targetPcName = read-host "PC Name is ... "

while($true){
    $result = test-netconnection $targetPcName
    write-output $result.pingsucceeded
    start-sleep -seconds 60
}