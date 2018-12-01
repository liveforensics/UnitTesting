
param($BuildNumber)

Write-Host "Running BUILD Script for build " $BuildNumber

Push-Location

Get-Location

# bat "\"${tool 'VS2017'}\" MyClasses.sln /p:Configuration=Debug /p:Platform=\"Any CPU\" /p:ProductVersion=1.0.0.${env.BUILD_NUMBER}"
msbuild MyClasses.sln "/p:Configuration=Debug /p:Platform='Any CPU' /p:ProductVersion=1.0.0.$BuildNumber"

Pop-Location