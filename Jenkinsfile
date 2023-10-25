pipeline {
    agent any

    environment {
        GITHUB_CRED = credentials('githubcred')
        DOCKER_CRED = credentials('DockerCred')
        DOCKER_REPO = 'somabharathkumar/samplewebpage'
    }

    stages {
        stage('Checkout Code') {
            steps {
                script {
                    checkout([$class: 'GitSCM', branches: [[name: '*/main']], userRemoteConfigs: [[credentialsId: GITHUB_CRED, url: 'https://github.com/soma-bharath/CICD.git']]])
                }
            }
        }

        stage('Build and Push Docker Image') {
            steps {
                script {
                    def customImage = docker.build("${DOCKER_REPO}:${BUILD_NUMBER}", "-f Dockerfile .")
                    customImage.push()
                }
            }
        }
    }
}
