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

        stage('Build Docker Image') {
            steps {
                script {
                    def customImage = docker.build("${DOCKER_REPO}:${BUILD_NUMBER}", "-f Dockerfile .")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'DockerCred') {
                        def customImage = docker.image("${DOCKER_REPO}:${BUILD_NUMBER}")
                        customImage.push()
                    }
                }
            }
        }
    }
}
