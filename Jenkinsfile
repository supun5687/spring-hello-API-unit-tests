@Library('jenkins-shared-library') _

pipeline {
    agent {
        docker {
            image 'abhishekf5/maven-abhishek-docker-agent:v1'
            args '--user root -v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    environment {
        IMAGE_NAME = "supun1995/spring-11:${env.BUILD_NUMBER}"
    }

    options {
        buildDiscarder(logRotator(numToKeepStr: '20'))
        ansiColor('xterm')
        timestamps()
    }

    stages {
        stage('Prepare') {
            steps {
                script {
                    // Detect branch automatically from Multibranch Pipeline
                    branchName = "main"
                    echo "Triggered branch: ${branchName}"

                    // Load branch-specific config
                    config = config.getConfig(branchName)
                }
            }
        }

        stage('Build App') {
            steps {
                script {
                    buildApp(config)
                }
            }
        }

        stage('Docker Build & Push') {
            steps {
                script {
                    dockerBuildPush(config, IMAGE_NAME)
                }
            }
        }
    }
}
