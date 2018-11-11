pipeline {
  agent {
    node {
      label 'Windows One'
    }

  }
  stages {
    stage('Gittery') {
      steps {
        echo 'hello mark'
      }
    }
    stage('Buildery') {
      steps {
        bat 'c:\\tools\\nuget.exe restore MyClasses.sln'
		bat "\"${tool 'VS2017'}\" MyClasses.sln /p:Configuration=Release /p:Platform=\"Any CPU\" /p:ProductVersion=1.0.0.${env.BUILD_NUMBER}"
      }
    }
	stage('Testery') {
		bat '"C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\TestAgent\\Common7\\IDE\\Extensions\\TestPlatform\\vstest.console.exe" UnitTestProject1.dll /EnableCodeCoverage /Logger:trx'
		powershell '''$mstestPath = "C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\TestAgent\\Team Tools\\Dynamic Code Coverage Tools\\amd64\\CodeCoverage.exe" 
        Get-ChildItem . -Recurse -Filter *.coverage | 
        ForEach-Object {
			$temp = $_.Name + "xml"
            Write-Host $temp
            & $mstestPath analyze /output:vstest.coveragexml $_.FullName
            }
        Write-Host "OK"'''
	}
  }
  environment {
    test = '1'
  }
}

