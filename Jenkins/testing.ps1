Write-Host "Running TESTING Script"

Push-Location | Out-Null

$location = Get-Location

$location = Join-Path $location 'MyClassesTest\\bin\\debug'

Set-Location $location

vstest.console.exe MyClassesTest.dll /EnableCodeCoverage /Logger:trx

Pop-Location | Out-Null

# remember return 0 if all was well and something else if there was a problem
exit 1