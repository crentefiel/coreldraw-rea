@echo off
setlocal
cd /d "%~dp0"
if not exist "runtime\node_modules\.bin\rea.cmd" (
 echo Execute scripts\Instalar.ps1 primeiro.
 pause
 exit /b 1
)
set "PATH=%~dp0runtime\node_modules\.bin;%PATH%"
echo REA: digite rea --help para listar comandos ou rea setup para conectar seu agente.
cmd /k "rea --version"
