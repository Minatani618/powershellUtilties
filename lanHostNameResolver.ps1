<# 
つかいかた
検査対象拠点のセグメントを下記targetIP3Arr配列に追加してこのファイルを
実行すると同一ディレクトリにレポートファイルが生成される
#>

<# 検査したい拠点のセグメントを指定する #>
$targetIP3Arr=@(201,11,60,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220)

<# レポートのパス #>
$time= Get-Date -format "yyyyMMdd-HHmm"
$dirname =Get-Location
$reportPath = $dirname.path + "\resolveReport_" + $time + ".csv"

<# ipから名前解決する #>
function resolveIP($ip) {
    try {
        return Resolve-DnsName $ip -ErrorAction Stop <# resolve-dnsで存在しないとエラーとなり止まってしまうからtry-catch #>
    }
    catch {
        return ""
    }
}

<# 今回実行の条件を出力 #>
write-output "----------------------"
write-output "resolve start"
write-output "----------------------"

<# csvのヘッダ生成 #>
Write-output "ip,name,type,ttl,section,namehost" >> $reportPath

<# 対象のIPアドレスに対してresolve-dnsname #>
foreach($targetIP3 in $targetIP3Arr ){
    $ip12="192.168."
    $ip123=$ip12+$targetIP3+"."
    for ($i = 1; $i -lt 255; $i++) {
        $ip1234=$ip123+$i
        $result = resolveIP $ip1234
        <#$resultTxt <- IPアドレス, 結果 の形で出力したい #>
        $resultTxt= $ip1234 + ","
        if($result -eq ""){
            $resultTxt+="-"
        }else{
            $resultTxt+=$result.namehost
        }
        <# ファイル出力とコンソール出力 #>
        Write-output $resultTxt >> $reportPath
        write-output $resultTxt
    }
}