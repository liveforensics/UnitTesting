
param($BuildNumber)

Write-Host "Running BUILD Script for build" $BuildNumber

Push-Location

Get-Location

# bat "\"${tool 'VS2017'}\" MyClasses.sln /p:Configuration=Debug /p:Platform=\"Any CPU\" /p:ProductVersion=1.0.0.${env.BUILD_NUMBER}"
# msbuild MyClasses.sln /p:Configuration=Debug /p:Platform=\"Any CPU\" /p:ProductVersion=1.0.0.4
Write-Host "Restoring Nuget Packages"
nuget restore

Write-Host "Building the Project"
# Invoke-Expression -Command "msbuild myclasses.sln /p:Configuration=Debug /p:Platform='Any CPU' /p:ProductVersion=1.0.0.$BuildNumber"
msbuild myclasses.sln /p:Configuration=Debug /p:Platform='Any CPU' /p:ProductVersion=1.0.0.$BuildNumber | Out-Host
Pop-Location