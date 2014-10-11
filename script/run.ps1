Param(
  [switch]$dev
)

$args = @()

if ($dev) {
  $args += "--dev"
}

$args += "--"
$args += Resolve-Path app

Start-Process -FilePath .\atom-shell\atom.exe -ArgumentList $args
