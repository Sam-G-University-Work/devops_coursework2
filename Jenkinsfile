pipeline {
    environment {
     imageID = "onepoint16/cw2"
     dockerCredentials = 'dockerhub_id'
     dockerFile = ''   
    }
    agent any
    stages {
        stage('Clone Git Repository') {
		steps {
			git([url: 'https://github.com/onepoint16/coursework2.git', branch: 'main', credentialsId: 'github_id'])}}

      stage('Start Sonarqube Scanner') {
          environment {
              scannerHome = tool 'SonarQubeScanner'
                }
        
          steps {
              withSonarQubeEnv('sonarqube') {
                  sh "${scannerHome}/bin/sonar-scanner"
                  }
          }
      }

        stage('Build Docker Image') {
                steps{
                    script {
                        dockerImage = docker.build imageID}}
				}
	    
        stage('Push Image to DockerHub') {
		steps{
		    script {
			docker.withRegistry( '', dockerCredentials ) {
			dockerFile.push("$BUILD_NUMBER")
			dockerFile.push('latest')}}}
}
        stage('Delete Old Image') {
  		steps{
	    		sh "docker rmi $imagename:$BUILD_NUMBER"
  }
}
        stage ('Deploy Changes to Minikube') {
     		steps{
         		script {
			echo 'Using remote command over ssh'
			sh 'ssh ubuntu@18.210.15.221 kubectl set image deployments/coursework2 cw2=onepoint16/coursework2:"$BUILD_NUMBER"'}
     }
    }
      
        
    }
}
