Param(
  [switch]$dev
)

$args = @(Resolve-Path app)

if ($dev) {
  $args += "--dev=true"
}

Start-Process -FilePath .\atom-shell\atom.exe -ArgumentList $args
