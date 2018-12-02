
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
# msbuild myclasses.sln /p:Configuration=Debug /p:Platform='Any CPU' /p:ProductVersion=1.0.0.$BuildNumber | Out-Host

$Result = (Start-Process -FilePath 'msbuild.exe' -ArgumentList 'myclasses.sln /p:Configuration=Debug /p:Platform=\"Any CPU\" /p:ProductVersion=1.0.0.$BuildNumber' -Wait -NoNewWindow -PassThru).ExitCode
$Result
if($lastexitcode){
    Write-Host "EXITTCODE = $lastexitcode"
}else{
   Write-Host 'No Error reported'
}

Pop-Location