node('Windows One') {
    stage ('initialisation') {
        try {
            git 'https://github.com/liveforensics/simpleapp.git'
        } catch (err) {
            notify("Error ${err}")
            currentBuild.result = 'FAILURE'
        }
    }
    stage ('building') {
        try {
            dir('simple1') {
                bat 'c:\\tools\\nuget.exe restore'

                def build_artifacts = "simple1\\bin\\debug"
                def test_artifacts = "UnitTestProject1\\bin\\Debug\\TestResults"

                powershell '''import-module Invoke-Msbuild
                Invoke-MsBuild -Path .\\Simple1.sln
                '''
                stage('testing') {
                    dir('UnitTestProject1\\bin\\debug') {
                        bat '"C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\TestAgent\\Common7\\IDE\\Extensions\\TestPlatform\\vstest.console.exe" UnitTestProject1.dll /EnableCodeCoverage /Logger:trx'
                        try {
                            dir('TestResults') {
                                powershell '''$mstestPath = "C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\TestAgent\\Team Tools\\Dynamic Code Coverage Tools\\amd64\\CodeCoverage.exe" 
                                Get-ChildItem . -Recurse -Filter *.coverage | 
                                ForEach-Object {
                                    $temp = $_.Name + "xml"
                                    Write-Host $temp
                                    & $mstestPath analyze /output:vstest.coveragexml $_.FullName
                                }
                                Write-Host "OK"'''
                            }
                        } catch (err) {
                            notify("Error ${err}")
                        }

                        stage ('publishing') {
                            step([$class: 'MSTestPublisher'])
                        }
                    }
                }
                stage('archiving') {
                    archiveArtifacts artifacts: "${build_artifacts}\\*.exe", caseSensitive: false
                    archiveArtifacts artifacts: "${test_artifacts}\\*.trx", caseSensitive: false
                }
                notify('Success')
            }
        } catch (err) {
            notify("Error ${err}")
            currentBuild.result = 'FAILURE'
        }

    }
    stage ('cleaning up') {
        cleanWs()
    }
}


def notify(status){
    emailext (
            to: "liveforensicsuk@gmail.com",
            subject: "${status}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
            body: """<p>${status}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
        <p>Check console output at <a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a></p>""",
    )
}

