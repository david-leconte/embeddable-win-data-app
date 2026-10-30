$Version = '3.13.17'

$RootFolder = Split-Path -Parent $PSScriptRoot
$BuildFolder = Join-Path $RootFolder 'build'
$BuildTempFolder = Join-Path $BuildFolder 'temp'
$PythonFolder = Join-Path $RootFolder 'lib\python'

New-Item -ItemType Directory -Path $BuildFolder -Force | Out-Null
New-Item -ItemType Directory -Path $BuildTempFolder -Force | Out-Null
New-Item -ItemType Directory -Path $PythonFolder -Force | Out-Null

Invoke-WebRequest "https://www.python.org/ftp/python/$Version/python-$Version-embed-amd64.zip" -OutFile "$BuildTempFolder\python.zip"
Invoke-WebRequest 'https://bootstrap.pypa.io/get-pip.py' -OutFile "$BuildTempFolder\get-pip.py"

Expand-Archive "$BuildTempFolder\python.zip" -DestinationPath $PythonFolder -Force

Get-ChildItem "$PythonFolder\python*._pth" | ForEach-Object {
    Add-Content -LiteralPath $_.FullName -Value "`r`nimport site" -Encoding ASCII
}

& "$PythonFolder\python.exe" "$BuildTempFolder\get-pip.py"
& "$PythonFolder\python.exe" "-m" "pip" "install" "-r" "$BuildFolder\requirements.txt" "--cache-dir" "$BuildTempFolder\pip_cache" "--no-build-isolation"


Remove-Item $BuildTempFolder -Recurse -Force
