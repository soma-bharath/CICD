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
                    git branch: 'main', credentialsId: 'githubcred', url: 'https://github.com/soma-bharath/CICD.git'
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
        stage('create a conatiner'){
            steps{
                sh """\
        sudo docker run -dit -p 911:80 ${DOCKER_REPO}:${BUILD_NUMBER}
        """
            }
        }
    }
}
