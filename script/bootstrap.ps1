$version = Get-Content VERSION
$env:APP_VERSION = $version
& apm install
& npm install grunt-download-electron
& grunt bootstrap-win
