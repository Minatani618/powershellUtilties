<# 
【つかいかた】
以下targetfolderに対象のフォルダを記入して
このファイルを時間実行すると定期的に監視ログを吐く
 #>
$targetFolder="C:\Users\minat\Desktop\programs"

$path = Get-Location
$logFileName="watchingFileList.txt"
$logFilePath=Join-Path -Path $path -ChildPath $logFileName
$targetChildItems= Get-ChildItem $targetFolder

<# ログファイルの中身とフォルダ内アイテムを比較する#>
function readLogFile() {
    $textlines = Get-Content -Path $logFilePath
    $childItems= Get-ChildItem $targetFolder
    <# なくなったファイルがあるかどうかチェック #>
    Write-Output "--- lost file check ---"
    foreach($line in $textlines){
        $existsItem= $false
        foreach($item in $childItems){
            if($line -eq $item){
                $existsItem = $true
            }
        }
        if($existsItem -eq $false){
            $line
        }
    }
    <# 新規のファイルがあるかどうか #>
    Write-Output "--- new file check ---"
    foreach($item in $childItems){
        $existsItem= $false
        foreach($line in $textlines){
            if($item.Name -eq $line){
                $existsItem = $true
            }
        }
        if($existsItem -eq $false){
            $item.Name
        }
    }
}

<# 対象フォルダ内のアイテムをログファイルに出力 #>
function writeLogFile() {
    Clear-Content $logFilePath
    foreach($item in $targetChildItems){
        Write-Output $item.name >> $logFilePath
    }
}

<# タイムスタンプ #>
function writelogTime {
    $time = Get-Date
    Write-Output $time
}

writelogTime
readLogFile
writeLogFile