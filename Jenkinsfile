pipeline {
    agent {
        docker {
            image 'maven:3.9.0-openjdk-17'
            args '-v /root/.m2:/root/.m2'
        }
    }

    environment {
        AWS_REGION       = 'us-east-1'
        AWS_ACCOUNT_ID   = '123456789012'
        SONAR_HOST_URL   = 'https://sonarqube.example.com'
        IMAGE_NAME       = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/myapp"
    }

    options {
        buildDiscarder(logRotator(numToKeepStr: '20'))
        ansiColor('xterm')
        timestamps()
    }

    stages {

        stage('Checkout Code') {
            steps {
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: 'refs/heads/main']],
                    userRemoteConfigs: [[
                        url: 'https://github.com/supun5687/spring-hello-API-unit-tests.git',
                        credentialsId: 'git-https-creds'
                    ]]
                ])
            }
        }

        stage('Build & Unit Tests') {
            steps {
                sh 'mvn clean verify -B'
            }
            post {
                always {
                    junit '**/target/surefire-reports/*.xml'
                }
            }
        }
    }
}
