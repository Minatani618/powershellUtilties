<# 
つかいかた
このプログラムは以下の引数をつけて呼び出すこと
1 検査するipネットワークの第三セグメント
2 検査するip第四セグメント範囲の最初の値
3 検査するip第四セグメント範囲の最後の値
4 接続確認するかどうか 1ならする、そうでなければしない 
 #>


<# 検査IPアドレス生成 #>
$ip12 = "192.168."
$ip3 = $args[0]
$ip123 = $ip12 +$ip3 +"."

<# オプション設定 しっかりorかんたん #>
$shouldCheckExists = $args[3]

<# ipから名前解決する #>
function getHostName($ip4) {
    $ip = $ip123+$ip4 
    try {
        $result=Resolve-DnsName $ip -ErrorAction Stop <# resolve-dnsで存在しないとエラーとなり止まってしまうからtry-catch #>
        return $result.namehost
    }
    catch {
        return "not found"
    }
}

<# ipからpingを飛ばす #>
function existsHost($ip4){
    $ip = $ip123 + $ip4
    $result = Test-NetConnection $ip -ErrorAction Stop
    return $result.PingSucceeded
}

<# 上記関数を実行する #>
function showIpStatus($ip4 , $shouldCheckExists) {

    <# 接続確認までするかどうかコマンドライン引数で判断(1なら確認する) #>
    if($shouldCheckExists -eq 1){
            $exist = existsHost $ip4
    }else{
            $exist="didn't run exist test. " <# 接続確認しないときに表示される文字列 #>
    }
    $hostName = getHostName $ip4
    $ip = $ip123 + $ip4
    $result = $ip + ", " + $hostName + ", " + $exist
    return $result
}

<# ipの第四セグメントについて検査の範囲をコマンドライン引数から指定する #>
$firstIp4 = $args[1]
$lastIp4 = $args[2] +1

<# 今回実行の条件を出力 #>
$msg1 = "target is " + $ip123 +"x"  
$msg2 = "range is  " + $firstIp4 + " ~ " +$lastIp4
$msg3 = if($shouldCheckExists -eq 1){ Write-Output "exist test mode." }else{ Write-Output "easy mode." }<# なんでpowershellには三項演算子がないの? #>
write-output "----------------------"
write-output $msg1
write-output $msg2
write-output $msg3
write-output "----------------------"

for ($i = $firstIp4; $i -lt $lastIp4; $i++) {
    $result = showIpStatus $i $shouldCheckExists
    Write-Host $result
}