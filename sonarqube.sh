#! /bin/bash
docker exec jenkins-container mkdir /var/jenkins_home/sonarqube
docker exec jenkins-container wget -O /var/jenkins_home/sonarqube/sonar-scanner-cli-3.3.0.1492-linux.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-3.3.0.1492-linux.zip
docker exec jenkins-container unzip -o  /var/jenkins_home/sonarqube/sonar-scanner-cli-3.3.0.1492-linux.zip 
docker exec jenkins-container rm /var/jenkins_home/sonarqube/sonar-scanner-3.3.0.1492-linux/jre/bin/java
docker exec jenkins-container ln -s /usr/lib/jvm/java-1.8-openjdk/bin/java /var/jenkins_home/sonarqube/sonar-scanner-3.3.0.1492-linux/jre/bin/java
