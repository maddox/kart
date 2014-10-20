$appPath = Resolve-Path app
$args = @("--dev", "--", $appPath)
Start-Process -FilePath .\atom-shell\atom.exe -ArgumentList $args
