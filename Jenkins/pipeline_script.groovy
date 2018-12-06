node('DockerOne'){
    stage('prep') {
        def status = powershell(returnStatus: true, script: 'write-host "hello mark"; exit 1')
        if (status == 0) {
            echo "it worked"
        }
        else {
            echo "It DIDN'T work"
        }
        def msg = powershell(returnStdout: true, script: 'write-output "calling mark"; write-output "there\'s more"; exit 0')
        println msg
       cleanWs()
    }
    stage('gittery') {
       powershell 'start-process -wait -filepath "git" -ArgumentList "clone https://github.com/liveforensics/UnitTesting.git"'
    }
    dir('UnitTesting')
    {
        stage('buildery') {
            sendSplunkConsoleLog {
                def msg = powershell(returnStdout: true, script: 'if(Test-Path jenkins\\\\build.ps1) { Invoke-Expression -Command "jenkins\\\\build.ps1 -BuildNumber $env:BUILD_NUMBER"}')
            }
        }
        stage('testery') {
            powershell 'if(Test-Path jenkins\\testing.ps1) { Invoke-Expression -Command jenkins\\testing.ps1 }'
            sendSplunkFile excludes: '', includes: '**/*.trx, **/*.coveragexml', publishFromSlave: true, sizeLimit: '100MB'
        }
        stage('publishery') {
            powershell 'if(Test-Path jenkins\\publish.ps1) { Invoke-Expression -Command jenkins\\publish.ps1 }'
        }
        stage('provisionery') {
            powershell 'if(Test-Path jenkins\\provision.ps1) { Invoke-Expression -Command jenkins\\provision.ps1 }'
        }
        stage('robotics') {
            powershell 'if(Test-Path jenkins\\robot.ps1) { Invoke-Expression -Command jenkins\\robot.ps1 }'
        }
        stage('harvestery') {
            powershell 'if(Test-Path jenkins\\harvest.ps1) { Invoke-Expression -Command jenkins\\harvest.ps1 }'
        }
        stage('cleanery') {
            powershell 'if(Test-Path jenkins\\cleanup.ps1) { Invoke-Expression -Command jenkins\\cleanup.ps1 }'
        }
    }
}