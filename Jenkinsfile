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
		bat "\"${tool 'VS2017'}\" MyClasses.sln /p:Configuration=Debug /p:Platform=\"Any CPU\" /p:ProductVersion=1.0.0.${env.BUILD_NUMBER}"
      }
    }
	stage('Testery') {	
		steps {
		dir('MyClassesTest\\bin\\debug') {
			bat '"C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\TestAgent\\Common7\\IDE\\Extensions\\TestPlatform\\vstest.console.exe" MyClasses.dll /EnableCodeCoverage /Logger:trx'		
		}
		}
	}
  }
  environment {
    test = '1'
  }
}

