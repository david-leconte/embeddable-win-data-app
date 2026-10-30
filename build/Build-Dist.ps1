$Version = '3.13.18'
$AstralBuild = '20261026'

$RootFolder = Split-Path -Parent $PSScriptRoot
$BuildFolder = Join-Path $RootFolder 'build'
$BuildTempFolder = Join-Path $BuildFolder 'temp'
$LibFolder = Join-Path $RootFolder 'lib'

New-Item -ItemType Directory -Path $BuildFolder -Force | Out-Null
New-Item -ItemType Directory -Path $BuildTempFolder -Force | Out-Null
New-Item -ItemType Directory -Path $LibFolder -Force | Out-Null

Invoke-WebRequest "https://github.com/astral-sh/python-build-standalone/releases/download/$AstralBuild/cpython-$Version+$AstralBuild-x86_64-pc-windows-msvc-install_only_stripped.tar.gz" -OutFile "$BuildTempFolder\astral-python-build-standalone.tar.gz"
Invoke-WebRequest 'https://bootstrap.pypa.io/get-pip.py' -OutFile "$BuildTempFolder\get-pip.py"

tar -xzf "$BuildTempFolder\astral-python-build-standalone.tar.gz" -C $LibFolder
& "$LibFolder\python\python.exe" "-m" "pip" "install" "-r" "$BuildFolder\requirements.txt"

Remove-Item $BuildTempFolder -Recurse -Force
