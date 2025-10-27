pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps { checkout scm }
        }

        stage('Build Frontend') {
            steps {
                dir('frontend') {
                    sh 'npm ci'
                    sh 'npm run build'
                    archiveArtifacts artifacts: 'build/**', fingerprint: true
                }
            }
        }

        stage('Build Backend') {
            steps {
                dir('backend') {
                    sh 'mvn clean package -DskipTests'
                    archiveArtifacts artifacts: 'target/*.war', fingerprint: true
                }
            }
        }

        stage('Build Docker Images') {
            steps {
                sh 'docker build -t my-registry/frontend:${BUILD_ID} ./frontend'
                sh 'docker build -t my-registry/backend:${BUILD_ID} ./backend'
                sh 'docker push my-registry/frontend:${BUILD_ID}'
                sh 'docker push my-registry/backend:${BUILD_ID}'
            }
        }

        stage('Deploy to Integration') {
            steps {
                sh 'scp target/*.war user@integration-vm:/opt/backend/'
                sh 'scp -r frontend/build user@integration-vm:/var/www/frontend/'
            }
        }
    }
}
