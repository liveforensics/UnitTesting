
param($BuildNumber)

Write-Host "### Running BUILD Script for build" $BuildNumber "###"

Push-Location | Out-Null

Get-Location

# bat "\"${tool 'VS2017'}\" MyClasses.sln /p:Configuration=Debug /p:Platform=\"Any CPU\" /p:ProductVersion=1.0.0.${env.BUILD_NUMBER}"
# msbuild MyClasses.sln /p:Configuration=Debug /p:Platform=\"Any CPU\" /p:ProductVersion=1.0.0.4
Write-Host "Restoring Nuget Packages"
nuget restore

Write-Host "Building the Project"
# Invoke-Expression -Command "msbuild myclasses.sln /p:Configuration=Debug /p:Platform='Any CPU' /p:ProductVersion=1.0.0.$BuildNumber"
msbuild myclasses.sln /p:Configuration=Debug /p:Platform='Any CPU' /p:ProductVersion=1.0.0.$BuildNumber | Out-File c:\persist\buildresults.log
# $Result = (Start-Process -FilePath 'msbuild.exe' -ArgumentList 'myclasses.sln /p:Configuration=Debug /p:ProductVersion=1.0.0.$BuildNumber /p:Platform="Any CPU"' -Wait -PassThru).ExitCode


Pop-Location | Out-Null

# remember return 0 if all was well and something else if there was a problem
exit 0

