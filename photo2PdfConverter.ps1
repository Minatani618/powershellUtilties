function ConvertTo-PDF {
    param (
        [Parameter(Mandatory=$true)]
        [string]$inputImagePath,

        [Parameter(Mandatory=$true)]
        [string]$outputPDFPath
    )

    # ImageMagickのconvertコマンドのフルパスを指定して画像をPDFに変換します
    & "C:\Program Files\ImageMagick\convert.exe" $inputImagePath $outputPDFPath
}

# 画像ファイルのパスを指定します
$inputImagePath = "C:\Users\ec000376\Documents\powershellUtilties\test.png"

# 出力PDFファイルのパスを指定します
$outputPDFPath = "C:\Users\ec000376\Documents\powershellUtilties\test.pdf"

# 画像をPDFに変換します
ConvertTo-PDF -inputImagePath $inputImagePath -outputPDFPath $outputPDFPath