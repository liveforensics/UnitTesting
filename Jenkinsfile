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
    stage('Nuget') {
      steps {
        bat '"C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\BuildTools\\Common7\\Tools\\VsDevCmd.bat"'
      }
    }
  }
  environment {
    test = '1'
  }
}