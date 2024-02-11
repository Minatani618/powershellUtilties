<# 
�y���������z
�ȉ�targetfolder�ɑΏۂ̃t�H���_���L������
���̃t�@�C�������Ԏ��s����ƒ���I�ɊĎ����O��f��
 #>
$targetFolder="C:\Users\minat\Desktop\programs"

$path = Get-Location
$logFileName="watchingFileList.txt"
$logFilePath=Join-Path -Path $path -ChildPath $logFileName
$targetChildItems= Get-ChildItem $targetFolder

<# ���O�t�@�C���̒��g�ƃt�H���_���A�C�e�����r����#>
function readLogFile() {
    $textlines = Get-Content -Path $logFilePath
    $childItems= Get-ChildItem $targetFolder
    <# �Ȃ��Ȃ����t�@�C�������邩�ǂ����`�F�b�N #>
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
    <# �V�K�̃t�@�C�������邩�ǂ��� #>
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

<# �Ώۃt�H���_���̃A�C�e�������O�t�@�C���ɏo�� #>
function writeLogFile() {
    Clear-Content $logFilePath
    foreach($item in $targetChildItems){
        Write-Output $item.name >> $logFilePath
    }
}

<# �^�C���X�^���v #>
function writelogTime {
    $time = Get-Date
    Write-Output $time
}

writelogTime
readLogFile
writeLogFile