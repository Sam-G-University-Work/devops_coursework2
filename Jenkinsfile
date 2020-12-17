pipeline {
    environment {
     imageID = "1point16/cw2"
     dockerCredentials = 'DockerLogin'
     dockerFile = ''   
    }
    agent any
    stages {
	    // Clones the up to date repository from GitHub using credentials stored in Jenkins
        stage('Clone Git Repository') {
		steps {
			git([url: 'https://github.com/onepoint16/coursework2.git', branch: 'main', credentialsId: 'GitHub'])}}

	    
	    // SonnarQube Scanner is started and configured with credentials set in Jenkins
      stage('Start Sonarqube Scanner') {
          environment {
              scannerHome = tool 'SonarScanner'
                }
        
          steps {
              withSonarQubeEnv('SonarScanner') {
                  sh "${scannerHome}/bin/sonar-scanner"
                  }
          }
      }

	    
	    // Builds docker file using variable set above
        stage('Build Docker Image') {
                steps{
                    script {
                        dockerFile = docker.build imageID}}
				}
	    
	    
	    // Pushes the new build to the DockerHub Repository useing the variables from above
        stage('Push Image to DockerHub') {
		steps{
		    script {
			docker.withRegistry( '', dockerCredentials ) {
			dockerFile.push("$BUILD_NUMBER")
			dockerFile.push('latest')}}}
}
	    
	    // Changes are then deployed to the nodes within kubernetes cluster
        stage ('Deploy Changes to Minikube') {
     		steps{
         		script {
			echo 'Using remote command over ssh'
			sh 'ssh ubuntu@34.207.188.179 kubectl set image deployments/coursework2 cw2=1point16/cw2:"$BUILD_NUMBER"'}
     }
    }
      
        
    }
}
