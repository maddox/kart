$appPath = Resolve-Path app
$args = @("--dev", "--", $appPath)
Start-Process -FilePath electron -ArgumentList $args
