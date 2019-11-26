[CmdletBinding(SupportsShouldProcess)]
param(
    # Specifies the font name to install.  Default value will install all fonts.
    [Parameter(Position=0)]
    [string[]]
    $FontName = '*'
)

$client = New-Object "System.Net.WebClient" ; $client.DownloadFile("https://github.com/hantaotaohan/Dotfile/raw/master/Windows/Fonts/inziu-SC-bold.ttc","$HOME\Desktop\inziu-SC-bold.ttc")

$fontFiles = New-Object 'System.Collections.Generic.List[System.IO.FileInfo]'
foreach ($aFontName in $FontName) {
    Get-ChildItem $PSScriptRoot -Filter "${aFontName}.ttc" -Recurse | Foreach-Object {$fontFiles.Add($_)}
}

$fonts = $null
foreach ($fontFile in $fontFiles) {
    if ($PSCmdlet.ShouldProcess($fontFile.Name, "Install Font")) {
        if (!$fonts) {
            $shellApp = New-Object -ComObject shell.application
            $fonts = $shellApp.NameSpace(0x14)
        }
        $fonts.CopyHere($fontFile.FullName)
    }
}

$client = New-Object "System.Net.WebClient" ;
$client.DownloadFile("`
https://github.com/hantaotaohan/Dotfile/raw/master/Windows/Gvim81/Gvim.zip"`
,"$HOME\Desktop\Gvim.zip") ; 
Expand-Archive -Path Gvim.zip -DestinationPath $HOME\Desktop\ ; 
cd .\Vim\vim81\ ;  gvim -c ":PlugInstall";


$client = New-Object "System.Net.WebClient" ;
$client.DownloadFile("`
https://github.com/hantaotaohan/Dotfile/raw/master/Windows/Powershell/ColorTool.zip"`
,"$HOME\Desktop\ColorTool.zip") ;
Expand-Archive -Path $HOME\Desktop\ColorTool.zip -DestinationPath $HOME\Desktop\ ; cd $HOME\Desktop\ColorTool\ ;
.\ColorTool.exe OneHalfDark.itermcolors ;

if (!(Test-Path -Path $PROFILE )) { New-Item -Type File -Path $PROFILE -Force }
@"
Set-PSReadlineOption -EditMode Emacs
"@ > $PROFILE
Set-PSReadlineOption -EditMode Emacs

"Any key to exit"  ;
 Read-Host | Out-Null ;
Exit