
param($BuildNumber)

Write-Host "Running BUILD Script for build" $BuildNumber

Push-Location | Out-Null

Get-Location

# bat "\"${tool 'VS2017'}\" MyClasses.sln /p:Configuration=Debug /p:Platform=\"Any CPU\" /p:ProductVersion=1.0.0.${env.BUILD_NUMBER}"
# msbuild MyClasses.sln /p:Configuration=Debug /p:Platform=\"Any CPU\" /p:ProductVersion=1.0.0.4
Write-Host "Restoring Nuget Packages"
nuget restore

Write-Host "Building the Project"
# Invoke-Expression -Command "msbuild myclasses.sln /p:Configuration=Debug /p:Platform='Any CPU' /p:ProductVersion=1.0.0.$BuildNumber"
# msbuild myclasses.sln /p:Configuration=Debug /p:Platform='Any CPU' /p:ProductVersion=1.0.0.$BuildNumber | Out-Host
# $Result = (Start-Process -FilePath 'msbuild.exe' -ArgumentList 'myclasses.sln /p:Configuration=Debug /p:ProductVersion=1.0.0.$BuildNumber /p:Platform="Any CPU"' -Wait -PassThru).ExitCode

$proc = Start-Process -FilePath 'msbuild.exe' -ArgumentList 'myclasses.sln /p:Configuration=Debug /p:ProductVersion=1.0.0.$BuildNumber /p:Platform="Any CPU"' -Wait -PassThru
$timeouted = $null
$proc | Wait-Process -Timeout 15 -ErrorAction SilentlyContinue -ErrorVariable timeouted
if ($timeouted)
{
    # terminate the process
    $proc | Stop-Process
    Write-Host "TIME OUT happened"
    # update internal error counter
}
elseif ($proc.ExitCode -ne 0)
{
    Pop-Location | Out-Null
    exit 1
}

# if($Result){
#     Write-Host "EXITTCODE = $Result"
# }else{
#    Write-Host 'No Exit Code reported'
# }

Pop-Location | Out-Null

return 1


