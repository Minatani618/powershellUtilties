
<# $basePath = "\\egacn-10\C$\Users\ec000154" #>
$basePath = Read-Host "Write target folder, please. "

<# レポートのパス #>
$time= Get-Date -format "yyyyMMdd-HHmm"
$dirname =Get-Location
$reportPath = $dirname.path + "\folderMap_" + $time + ".txt"

<# 再帰処理: 指定したパスのサブディレクトリをどんどん深く掘ってパスを出力する #>
function writeSubDir ($targetPath) {
    if(!$basePath){
        return
    }

    $children = Get-ChildItem $targetPath
    foreach ($child in $children) {
        <# 子のアイテムのうちディレクトリなら出力して再帰呼び出し #>
        if($child.psiscontainer){
            $nextDir = Join-Path $targetPath $child
            Write-Output $nextDir >> $reportPath
            writeSubDir $nextDir
        }else{
            $filePath = Join-Path $targetPath $child
            Write-Output $filePath >> $reportPath
        }
    }
}

writeSubDir $basePath


pause