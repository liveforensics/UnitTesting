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
        bat 'nuget restore MyClasses.sln'
		bat "\"${tool 'MSBuild'}\" MyClasses.sln /p:Configuration=Release /p:Platform=\"Any CPU\" /p:ProductVersion=1.0.0.${env.BUILD_NUMBER}"
      }
    }
  }
  environment {
    test = '1'
  }
}

