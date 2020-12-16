pipeline {
    environment {
     imageID = "1point16/cw2"
     dockerCredentials = 'DockerLogin'
     dockerFile = ''   
    }
    agent any
    stages {
        stage('Clone Git Repository') {
		steps {
			git([url: 'https://github.com/onepoint16/coursework2.git', branch: 'main', credentialsId: 'Git'])}}

      stage('Start Sonarqube Scanner') {
          environment {
              scannerHome = tool 'SonarQubeScanner'
                }
        
          steps {
              withSonarQubeEnv('SonarQube') {
                  sh "${scannerHome}/bin/sonar-scanner"
                  }
          }
      }

        stage('Build Docker Image') {
                steps{
                    script {
                        dockerFile = docker.build imageID}}
				}
	    
        stage('Push Image to DockerHub') {
		steps{
		    script {
			docker.withRegistry( '', dockerCredentials ) {
			dockerFile.push("$BUILD_NUMBER")
			dockerFile.push('latest')}}}
}
        stage ('Deploy Changes to Minikube') {
     		steps{
         		script {
			echo 'Using remote command over ssh'
			sh 'ssh ubuntu@54.90.40.166 kubectl set image deployments/coursework2 cw2=onepoint16/coursework2:"$BUILD_NUMBER"'}
     }
    }
      
        
    }
}
