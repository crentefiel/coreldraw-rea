$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
if (!(Get-Command npm.cmd -ErrorAction SilentlyContinue)) { throw 'Instale Node.js/npm antes de continuar.' }
$skillRoot = if ($env:CODEX_HOME) { Join-Path $env:CODEX_HOME 'skills' } else { Join-Path $env:USERPROFILE '.codex\skills' }
$dest = Join-Path $skillRoot 'coreldraw-rea'
$source = Join-Path $root 'skills\coreldraw-rea'
if (Test-Path $dest) {
    $backup = $dest + '.backup'
    if (!(Test-Path $backup)) { Copy-Item -LiteralPath $dest -Destination $backup -Recurse }
}
New-Item -ItemType Directory -Force $dest | Out-Null
Copy-Item -Path (Join-Path $source '*') -Destination $dest -Recurse -Force
& npm.cmd install --prefix (Join-Path $root 'runtime') rea-agents@6.5.0 --no-audit --no-fund
if ($LASTEXITCODE -ne 0) { throw 'npm falhou. A skill foi copiada, mas confira a instalação do REA.' }
Write-Output "Skill instalada em $dest. Abra Iniciar-REA.cmd. Reinicie o agente para descobrir a skill."
