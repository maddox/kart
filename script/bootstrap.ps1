$version = Get-Content VERSION
$env:APP_VERSION = $version
& apm install
& npm install grunt-download-atom-shell
& grunt bootstrap-win
