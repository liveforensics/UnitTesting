Write-Host "### Running TESTING Script ###"

Push-Location | Out-Null

$location = Get-Location

$results = Join-Path $location "RealTestResults"
if (-not (test-path $results))
{
    New-Item $results -ItemType Directory -Force
}

$location = Join-Path $location 'MyClassesTest\\bin\\debug'

Set-Location $location

vstest.console.exe MyClassesTest.dll /Logger:trx /Enablecodecoverage

Get-ChildItem . -File -Recurse | Where-Object {$_.Extension -eq '.coverage'; } | ForEach-Object {
    Write-Host "Found: " $_.FullName
    Move-Item $_.FullName -Destination $results -Force
}

Set-Location $results
Get-ChildItem . -File | Where-Object {$_.Extension -eq '.coverage'; } | ForEach-Object {
    Write-Host "Processing: " $_.FullName
    $target = $_.Name + 'xml'
    codecoverage analyze /output:$target $_.FullName
}

# $args = "collect /output:test.coverage .\\MyClassesTest.dll"

# Start-Process -FilePath codecoverage.exe -ArgumentList $args -Wait -PassThru -Verb runAs 
#codecoverage.exe collect /output:test.coverage .\MyClassesTest.dll
# codecoverage.exe analyze /output:test.coveragexml .\test.coverage

Pop-Location | Out-Null

# remember return 0 if all was well and something else if there was a problem
exit 0