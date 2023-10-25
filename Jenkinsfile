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
        docker run -dit -p ${BUILD_NUMBER}:80 ${DOCKER_REPO}:${BUILD_NUMBER}
        """
            }
        }
            stage('Trigger ManifestUpdate') {
                steps{
                echo "triggering updatemanifestjob"
                build job: 'updatemanifest', parameters: [string(name: 'DOCKERTAG', value: env.BUILD_NUMBER)]
                }
        }
    }
}
