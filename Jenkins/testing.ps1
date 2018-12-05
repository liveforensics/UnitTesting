Write-Host "### Running TESTING Script ###"

Push-Location | Out-Null

$location = Get-Location

$location = Join-Path $location 'MyClassesTest\\bin\\debug'

Set-Location $location

vstest.console.exe MyClassesTest.dll /Logger:trx /ResultsDirectory:c:\\persist

Get-ChildItem . -File -Recurse | Where-Object {$_.Extension -eq '.coverage'; } | ForEach-Object {
    Write-Host "Found: " $_.FullName
}

codecoverage.exe collect /output:test.coverage .\MyClassesTest.dll
codecoverage.exe analyze /output:test.coveragexml .\test.coverage

Pop-Location | Out-Null

# remember return 0 if all was well and something else if there was a problem
exit 0