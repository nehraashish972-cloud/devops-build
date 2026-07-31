pipeline {
    agent any
    environment {
        DOCKERHUB_CREDS = credentials('dockerhub-creds')
    }
    stages {
        stage('Checkout') {
            steps { checkout scm }
        }
        stage('Determine Target Repo') {
            steps {
                script {
                    env.IMAGE_REPO = (env.BRANCH_NAME == 'master' || env.BRANCH_NAME == 'main') ? 'devops-build-prod' : 'devops-build-dev'
                }
            }
        }
        stage('Docker Build') {
            steps {
                sh 'docker build -t $DOCKERHUB_CREDS_USR/$IMAGE_REPO:latest .'
            }
        }
        stage('Docker Push') {
            steps {
                sh '''
                echo $DOCKERHUB_CREDS_PSW | docker login -u $DOCKERHUB_CREDS_USR --password-stdin
                docker push $DOCKERHUB_CREDS_USR/$IMAGE_REPO:latest
                '''
            }
        }
        stage('Deploy') {
            steps {
                sh '''
                docker stop devops-app || true
                docker rm devops-app || true
                docker run -d --name devops-app -p 80:80 --restart unless-stopped $DOCKERHUB_CREDS_USR/$IMAGE_REPO:latest
                '''
            }
        }
    }
}
