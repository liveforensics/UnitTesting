pipeline {
  agent {
    node {
      label 'DockerOne'
      cleanWs()
    }

  }
  stages {
    stage('Gittery') {
      steps {
        echo 'hello mark'
      }
    }
    stage('Call Test') {
      steps {
        powershell 'if(Test-Path jenkins\\build.ps1) { Invoke-Expression -Command jenkins\\build.ps1}'
      }
    }
    // stage('Buildery') {
    //   steps {
    //     bat 'c:\\tools\\nuget.exe restore MyClasses.sln'
		//     bat "\"${tool 'VS2017'}\" MyClasses.sln /p:Configuration=Debug /p:Platform=\"Any CPU\" /p:ProductVersion=1.0.0.${env.BUILD_NUMBER}"
    //   }
    // }
	  // stage('Testery') {	
		//   steps {
		//     dir('MyClassesTest\\bin\\debug') {
		//   	  bat "\"${tool 'VSTEST'}\"vstest.console.exe MyClasses.dll /EnableCodeCoverage /Logger:trx"
	  // 	  }
	  // 	}
	  // }
  }
  environment {
    test = '1'
  }
}

