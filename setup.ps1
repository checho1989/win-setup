# Windows setup: debloat + telemetry/ads off + Chrome, Adobe Reader, Office.
# Run in PowerShell as Administrador:  irm https://raw.githubusercontent.com/checho1989/win-setup/main/setup.ps1 | iex
$ErrorActionPreference = 'Continue'
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole('Administrator')) {
    Write-Host 'Abre PowerShell como Administrador y vuelve a ejecutar.' -ForegroundColor Red; return
}

Write-Host '== 1/2 Debloat (Win11Debloat de Raphire) ==' -ForegroundColor Cyan
& ([scriptblock]::Create((irm 'https://debloat.raphi.re/'))) -Silent -RunDefaults

Write-Host '== 2/2 Programas (winget) ==' -ForegroundColor Cyan
$apps = 'Google.Chrome', 'Adobe.Acrobat.Reader.64-bit', 'Microsoft.Office'
foreach ($id in $apps) {
    winget install --id $id -e --silent --accept-package-agreements --accept-source-agreements
}
Write-Host 'Listo. Reinicia el equipo. Office se activa iniciando sesion con una licencia/cuenta Microsoft 365.' -ForegroundColor Green
